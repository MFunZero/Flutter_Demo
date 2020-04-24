import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 跨组件状态共享
///
///
///
// void main() => runApp(ProviderApp());

class ProviderApp extends StatelessWidget {
  const ProviderApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "跨组件共享状态",
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text("共享状态"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: ProviderRoute(),
      ),
    );
  }
}

Type _typeOf<T>() => T;

class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  final T data;

  // static InheritedProvider of(BuildContext context) {
  //   return (context.dependOnInheritedWidgetOfExactType(aspect: InheritedProvider)as InheritedProvider<T>);
  // }

  @override
  bool updateShouldNotify(InheritedProvider<T> oldWidget) {
    return true;
  }
}

///
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T data;

  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child,
  });

  /// 优化，加入是否监听
  ///  //添加一个listen参数，表示是否建立依赖关系
  static T of<T>(BuildContext context, {bool listen = true}) {
    final type = _typeOf<InheritedProvider<T>>();
    // context.dependOnInheritedWidgetOfExactType(type)
    final provider = listen
        ? context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>
        : context.ancestorInheritedElementForWidgetOfExactType(type)?.widget
            as InheritedProvider<T>;
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    setState(() {}); //更新UI
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(data: widget.data, child: widget.child);
  }
}

class Item {
  double price;
  int count;
  String name;
  Item(this.name, this.price, this.count);
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者), 重新构建InheritedProvider,更新状态
    notifyListeners();
  }
}

class ProviderRoute extends StatefulWidget {
  ProviderRoute({Key key}) : super(key: key);

  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        // 订阅 ChangeNotifierProvider
        data: CartModel(), // 依赖CartModel
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Builder(builder: (context) {
                var cart = ChangeNotifierProvider.of<CartModel>(context);
                if (cart.items.length == 0) {
                  return Text("总价:${cart.totalPrice}");
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: cart.items.length,
                        itemExtent: 50.0,
                        itemBuilder: (BuildContext context, int index) {
                          var model = cart.items[index];
                          // return ListTile(
                          //     title: Text(
                          //         "商品名称：${model.name},商品价格：${model.price}￥"));
                          ///优化
                          return Consumer<CartModel>(
                              builder: (context, cart) => Text(
                                  "商品名称：${model.name},商品价格：${model.price}￥"));
                        }),
                  );
                }
              }),
              Builder(builder: (context) {
                print("RaisedButton build"); //在后面优化部分会用到
                return RaisedButton(
                    child: Text("添加商品"),
                    onPressed: () {
                      // way1 存在性能问题
                      // ”添加商品“按钮本身没有变化，是不应该被重新build的
                      var cartModel = ChangeNotifierProvider.of<CartModel>(
                          context,
                          listen: false);
                      cartModel.add(
                          Item("测试 ${cartModel.items.length + 1}", 20.0, 1));
                      print(cartModel.items.length);
                    });
              }),
            ],
          );
        }),
      ),
    );
  }
}

/// 优化
class Consumer<T> extends StatelessWidget {
  const Consumer({Key key, @required this.builder, this.child})
      : super(key: key);

  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, ChangeNotifierProvider.of(context)); //自动获取model
  }
}
