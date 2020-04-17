import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:english_words/english_words.dart';
import 'ProviderTest.dart';

void main() => runApp(MyApp());

// void main() => runApp(LoginPage());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return CupertinoApp(
    //   title: "测试",
    //   theme: CupertinoThemeData(primaryColor: CupertinoColors.systemYellow),
    //   home: MyHomePage(),
    // );
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.blue,
        ),
        home: MyHomePage(),
            //BottomNavBarRoute() //CustomScrollViewTestRoute()//ScrollControllerTestRoute()// BottomNavBarRoute(),
        // ScaffoldRoute(), // CounterWidget(),//MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    // return CounterWidget();
    return Scaffold(
      appBar: AppBar(title: Text("子树中获取State对象")),
      body: ConstrainedBoxTest(),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     // Here we take the value from the MyHomePage object that was created by
    //     // the App.build method, and use it to set our appbar title.
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     // Center is a layout widget. It takes a single child and positions it
    //     // in the middle of the parent.
    //     child: Column(
    //       // Column is also a layout widget. It takes a list of children and
    //       // arranges them vertically. By default, it sizes itself to fit its
    //       // children horizontally, and tries to be as tall as its parent.
    //       //
    //       // Invoke "debug painting" (press "p" in the console, choose the
    //       // "Toggle Debug Paint" action from the Flutter Inspector in Android
    //       // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
    //       // to see the wireframe for each widget.
    //       //
    //       // Column has various properties to control how it sizes itself and
    //       // how it positions its children. Here we use mainAxisAlignment to
    //       // center the children vertically; the main axis here is the vertical
    //       // axis because Columns are vertical (the cross axis would be
    //       // horizontal).
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text(
    //           'You have pushed the button this many times:',
    //         ),
    //         Text(
    //           '$_counter',
    //           style: Theme.of(context).textTheme.display1,
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     child: Icon(Icons.add),
    //   ), // This trailing comma makes auto-formatting nicer for build methods
    // );
  }
}

class CounterWidget extends StatefulWidget {
  CounterWidget({Key key, this.initValue: 0}) : super(key: key);
  final int initValue;
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counter = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: FlatButton(
    //       color: Colors.blue,
    //       child: Text('$_counter'),
    //       onPressed: ()=>setState(()=>++_counter),
    //     )
    //   ),
    // );
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(title: Text("子树中获取State对象")),
      body: Center(
        child: Builder(
          builder: (context) {
            return RaisedButton(
              onPressed: () {
                // context.findAncestorStateOfType()
                // ScaffoldState _state = context.findAncestorStateOfType(State<Scaffold>());
                // way 1
                // Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text("我是snackBar"),),
                // );
                // way 2
                // ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
                // _state.showSnackBar(
                //     SnackBar(content: Text("我是snackBar"),),
                // );
                // way 3
                print(_globalKey.currentWidget);
                _globalKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text("我是snackBar"),
                  ),
                );
              },
              child: Text("显示snackBar"),
            );
          },
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

class CupertinoTestRoute extends StatelessWidget {
  const CupertinoTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
            color: CupertinoColors.systemBlue,
            child: Text("Press"),
            onPressed: () {}),
      ),
      navigationBar: CupertinoNavigationBar(
        middle: Text("标题"),
      ),
    );
  }
}

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  SwitchAndCheckBoxTestRoute({Key key}) : super(key: key);

  @override
  _SwitchAndCheckBoxTestRouteState createState() =>
      _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  // bool _switchSelected = true;
  // bool _checkboxSelected = true;
  TextEditingController _unameController = TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // return Column(
    //     children: <Widget>[
    //       Switch(
    //           value: _switchSelected,
    //           onChanged: (value) {
    //             setState(() {
    //               _switchSelected = value;
    //             });
    //           }),
    //       Checkbox(
    //           value: _checkboxSelected,
    //           activeColor: Colors.red,
    //           onChanged: (value) {
    //             setState(() {
    //               _checkboxSelected = value;
    //             });
    //           }),
    //     ],
    //   );

    // return Column(
    //   children: <Widget>[
    //     TextField(
    //       autofocus: true,
    //       controller: _unameController,
    //       decoration: InputDecoration(
    //         labelText: "用户名",
    //         hintText: "用户名或邮箱",
    //         prefixIcon: Icon(Icons.person),
    //       ),
    //     ),
    //     TextField(
    //       decoration: InputDecoration(
    //         labelText: "密码",
    //         hintText: "您的登录密码",
    //         prefixIcon: Icon(Icons.lock)
    //       ),
    //       obscureText: true,
    //     ),
    //   ],
    // );
    List<Widget> widgetList = [];

    Widget temp = Theme(
        data: Theme.of(context).copyWith(
            hintColor: Colors.grey[200], //定义下划线颜色
            inputDecorationTheme: InputDecorationTheme(
                // labelStyle: TextStyle(color: Colors.grey), //定义label字体样式
                hintStyle:
                    TextStyle(color: Colors.grey, fontSize: 14.0) //定义提示文本样式
                )),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              Container(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "电子邮件地址",
                      prefixIcon: Icon(Icons.email),
                      border: InputBorder.none //隐藏下划线
                      ),
                  validator: (v) {
                    return v.trim().length > 5 ? null : "用户名不能小于5位";
                  },
                ),
                decoration: BoxDecoration(
                    // 下滑线浅灰色，宽度1像素
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.grey[200], width: 1.0))),
              ),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "密码",
                    hintText: "您的登录密码",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0)),
                obscureText: true,
                validator: (v) {
                  return v.trim().length > 5 ? null : "密码不能小于5位";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                          padding: EdgeInsets.all(10),
                          child: Text("登录"),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            if ((_formKey.currentState as FormState)
                                .validate()) {
                              print("校验通过");

                              Fluttertoast.showToast(
                                  msg: "This is Center Short Toast",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              //增加一层黑色背景透明度为0.8
                              // widgetList.add(
                              //   Opacity(
                              //       opacity: 0.8,
                              //       child: ModalBarrier(
                              //         color: Colors.black87,
                              //       )),
                              // );
                              // //环形进度条
                              // widgetList.add(Center(
                              //   child: CircularProgressIndicator(),
                              // ));

                              // widgetList.add(
                              //   Center(
                              //     child: ProgressRoute(),
                              //   ),
                              // );
                            }
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
    widgetList.add(temp);

    return temp;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _unameController.text = "MFun always fine";
    _unameController.selection = TextSelection(
        baseOffset: 2, extentOffset: _unameController.text.length);

    _unameController.addListener(() {
      print(_unameController.text);
    });
  }
}

class ProgressRoute extends StatefulWidget {
  ProgressRoute({Key key}) : super(key: key);

  @override
  _ProgressRouteState createState() => _ProgressRouteState();
}

class _ProgressRouteState extends State<ProgressRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                  .animate(_animationController),
              value: _animationController.value,
            ),
          ),
        ],
      ),
    );
  }
}

class ColumnRoute extends StatefulWidget {
  ColumnRoute({Key key}) : super(key: key);

  @override
  _ColumnRouteState createState() => _ColumnRouteState();
}

class _ColumnRouteState extends State<ColumnRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max, // 有效，外层Column高度为整个屏幕
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("hello world "),
                    Text("I am Jack "),
                  ],
                ),
              ),
            ),
            // Container(
            //   color: Colors.red,
            //   child: Column(
            //     mainAxisSize: MainAxisSize.max, // 无效，内层Column高度为实际高度
            //     children: <Widget>[
            //       Text("hello world "),
            //       Text("I am Jack "),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );

    // return Container(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Text("Hello Flutter"),
    //           Text("I am Rose"),
    //         ],
    //       ),
    //       Row(
    //         mainAxisSize: MainAxisSize.min,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Text("Hello Flutter"),
    //           Text("I am Rose"),
    //         ],
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           Text("Hello Flutter"),
    //           Text("I am Rose"),
    //         ],
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: <Widget>[
    //           Text("Hello Flutter"),
    //           Text("I am Rose"),
    //         ],
    //       ),
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         // textDirection: TextDirection.ltr,
    //         verticalDirection: VerticalDirection.up,
    //         children: <Widget>[
    //           Text(
    //             " hello world ",
    //             style: TextStyle(fontSize: 30.0),
    //           ),
    //           Text("I am Rose"),
    //         ],
    //       ),
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         textDirection: TextDirection.rtl,
    //         children: <Widget>[
    //           Text("Hello Flutter"),
    //           Text("I am Rose"),
    //         ],
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: <Widget>[
    //           Text("Hello Flutter"),
    //           Text("I am Rose"),
    //         ],
    //       ),
    //       ConstrainedBox(
    //         constraints: BoxConstraints(minWidth:double.infinity),
    //         child:
    //          Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: <Widget>[
    //             Text("Hi"),
    //             Text("World",)
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class FlexLayoutTestRoute extends StatefulWidget {
  FlexLayoutTestRoute({Key key}) : super(key: key);

  @override
  _FlexLayoutTestRouteState createState() => _FlexLayoutTestRouteState();
}

class _FlexLayoutTestRouteState extends State<FlexLayoutTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 100,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    // height: 30,
                    color: Colors.red,
                  ),
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 1,
                  child: Container(
                    // height: 30,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // TODO: implement getSize
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    throw oldDelegate != this;
  }
}

class WrapTestRoute extends StatefulWidget {
  WrapTestRoute({Key key}) : super(key: key);

  @override
  _WrapTestRouteState createState() => _WrapTestRouteState();
}

class _WrapTestRouteState extends State<WrapTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
      children: <Widget>[
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.red,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.green,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.blue,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.yellow,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.brown,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.purple,
        ),
      ],
    );
    // return Wrap(
    //   spacing: 8.0,
    //   runSpacing: 4.0,
    //   alignment: WrapAlignment.start,
    //   children: <Widget>[
    //     new Chip(
    //       avatar: new CircleAvatar(
    //         backgroundColor: Colors.blue,
    //         child: Text("A"),
    //       ),
    //       label: new Text("Hamilton"),
    //     ),
    //     new Chip(
    //       avatar:
    //           new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
    //       label: new Text('Lafayette'),
    //     ),
    //     new Chip(
    //       avatar:
    //           new CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
    //       label: new Text('Mulligan'),
    //     ),
    //     new Chip(
    //       avatar:
    //           new CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
    //       label: new Text('Laurens'),
    //     ),
    //   ],
    // );
  }
}

/// stack
class StackTestRoute extends StatefulWidget {
  StackTestRoute({Key key}) : super(key: key);

  @override
  _StackTestRouteState createState() => _StackTestRouteState();
}

class _StackTestRouteState extends State<StackTestRoute> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: Text("Hello world", style: TextStyle(color: Colors.white)),
            color: Colors.red,
          ),
          Positioned(
            left: 20.0,
            child: Text("I am jack"),
          ),
          Positioned(
            top: 20.0,
            child: Text("Your Friend"),
          ),
        ],
      ),
    );
  }
}

class AlignTestRoute extends StatefulWidget {
  AlignTestRoute({Key key}) : super(key: key);

  @override
  _AlignTestRouteState createState() => _AlignTestRouteState();
}

class _AlignTestRouteState extends State<AlignTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          //  height: 120,
          //  width: 120,
          color: Colors.green,
          child: Align(
            widthFactor: 2.0,
            heightFactor: 2.0, // 同 container中设置宽高
            alignment:
                FractionalOffset(0.5, 0.5), // 坐标(30,30)  //Alignment(2,0.0),
            child: FlutterLogo(
              size: 60,
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.green),
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: Text("Hello world"),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          child: Center(
            child: Text("xxx"),
          ),
        ),
      ],
    );
  }
}

class ConstrainedBoxTest extends StatefulWidget {
  ConstrainedBoxTest({Key key}) : super(key: key);

  @override
  _ConstrainedBoxTestState createState() => _ConstrainedBoxTestState();
}

class _ConstrainedBoxTestState extends State<ConstrainedBoxTest> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints(
    //       minHeight: 50.0,
    //       minWidth: double.infinity,
    //     ),
    //     child: Container(
    //       height: 5.0,
    //       child: DecoratedBox(
    //         decoration: BoxDecoration(
    //           color: Colors.red,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    // return ConstrainedBox(
    //   constraints: BoxConstraints(
    //     minWidth: 60.0,
    //     minHeight: 60.0,
    //   ),
    //   child: UnconstrainedBox(  //去除父限制对子元素的影响，父限制依旧在
    //     child: ConstrainedBox(constraints: BoxConstraints(minWidth: 60.0, minHeight: 20.0),
    //       child: DecoratedBox(decoration: BoxDecoration(
    //         color: Colors.red,
    //       ),
    //       ),
    //     ),
    //   ),
    // );

    // return DecoratedBox(
    //     decoration: BoxDecoration(
    //         gradient:
    //             LinearGradient(colors: [Colors.red, Colors.orange[700]]), //背景渐变
    //         borderRadius: BorderRadius.circular(3.0), //3像素圆角
    //         boxShadow: [
    //           //阴影
    //           BoxShadow(
    //               color: Colors.black54,
    //               offset: Offset(2.0, 2.0),
    //               blurRadius: 4.0)
    //         ]),
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
    //       child: Text(
    //         "Login",
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     ));

    // return DecoratedBox(decoration: BoxDecoration(
    //   color: Colors.red,
    // ),
    // child: Transform.translate(offset: Offset(20,25.0),
    //   child: Text("Hello world"),
    // ),
    // );

    return Container(
      margin: EdgeInsets.only(top: 50.0, left: 120.0),
      constraints: BoxConstraints.tightFor(width: 200, height: 150),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.red, Colors.orange],
          center: Alignment.topLeft,
          radius: .98,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4.0)
        ],
      ),
      transform: Matrix4.rotationZ(.2),
      alignment: Alignment.center,
      child: //点击该按钮后弹出对话框
          RaisedButton(
        child: Text("对话框1"),
        onPressed: () async {
          //弹出对话框并等待其关闭
          // bool delete = await showDeleteConfirmDialog1();
          // if (delete == null) {
          //   print("取消删除");
          // } else {
          //   print("已确认删除");
          //   //... 删除文件
          // }
          // await changeLanguage();
          await showListDialog();
        },
      ),
    );
  }

  Future<void> changeLanguage() async {
  int i = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('请选择语言'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                // 返回1
                Navigator.pop(context, 1);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text('中文简体'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                // 返回2
                Navigator.pop(context, 2);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text('英国英语'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                // 返回2
                Navigator.pop(context, 2);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text('美国英语'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                // 返回2
                Navigator.pop(context, 2);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text('印度英语'),
              ),
            ),
          ],
        );
      });

  if (i != null) {
    print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
  }
}

Future<void> showListDialog() async {
  int index = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      var child = Column(
        children: <Widget>[
          ListTile(title: Text("请选择")),
          Expanded(
              child: ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("$index"),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
          )),
        ],
      );
      //使用AlertDialog会报错
      //return AlertDialog(content: child);
      // way1
      // return Dialog(child: child);
      //way2
      return UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300),
          child: Material(
            child: child,
            type: MaterialType.card,
          ),
        ),
      );
    },
  );
  if (index != null) {
    print("点击了：$index");
  }
}

// 弹出对话框
  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}

// TabBarController 以及SegmentController
class ScaffoldRoute extends StatefulWidget {
  ScaffoldRoute({Key key}) : super(key: key);

  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;

  TabController _tabController;
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Test"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
        // 替换openDrawer按钮
        leading: Builder(builder: (context) {
          return IconButton(
              icon: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      drawer: new MyDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
    );
  }
}

// 侧滑抽屉
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "WWWWW",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// tabBarItem 凸起样式
class BottomNavBarRoute extends StatefulWidget {
  BottomNavBarRoute({Key key}) : super(key: key);

  @override
  _BottomNavBarRouteState createState() => _BottomNavBarRouteState();
}

class _BottomNavBarRouteState extends State<BottomNavBarRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.home), onPressed: () {}),
              SizedBox(),
              IconButton(icon: Icon(Icons.business), onPressed: () {}),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new WillPopScopeTestRoute()));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body:
          InheritedWidgetTestRoute(), //InfinitedGridView(), //GridViewTest(), //SingleChildScrollViewTestRoute(),
    );
  }
}

/// 常SingleChildScrollView只应在期望的内容不会超过屏幕太多时使用，
/// 这是因为SingleChildScrollView不支持基于Sliver的延迟实例化模型，
/// 所以如果预计视口可能包含超出屏幕尺寸太多的内容时，
/// 那么使用SingleChildScrollView将会非常昂贵（性能差），
/// 此时应该使用一些支持Sliver延迟加载的可滚动组件，如ListView

class SingleChildScrollViewTestRoute extends StatelessWidget {
  const SingleChildScrollViewTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    // return Scrollbar(
    //   child: SingleChildScrollView(
    //     padding: EdgeInsets.all(15),
    //     child: Center(
    //       child: Column(
    //         children: str
    //             .split("")
    //             .map((e) => Text(
    //                   e,
    //                   textScaleFactor: 2.0,
    //                 ))
    //             .toList(),
    //       ),
    //     ),
    //   ),
    // );

    /// 可滚动组件通过一个List来作为其children属性时，只适用于子组件较少的情况，
    /// 这是一个通用规律，并非ListView自己的特性，像GridView也是如此。
    /// ListView.builder适合列表项比较多（或者无限）的情况，
    /// 因为只有当子组件真正显示的时候才会被创建，也就说通过该构造函数创建的ListView是支持基于Sliver的懒加载模型的
    // return ListView(
    //   shrinkWrap: true, //根据子组件确定ListView高度
    //   padding: const EdgeInsets.all(20.0),
    //   children: <Widget>[
    //     const Text('I\'m dedicating every day to you'),
    //     const Text('Domestic life was never quite my style'),
    //     const Text('When you smile, you knock me out, I fall apart'),
    //     const Text('And I thought I was so smart'),
    //   ],
    // );

    /// ListView.builder
    return Column(children: <Widget>[
      ListTile(title: Text("商品列表")),
      // SizedBox(
      //   //Material设计规范中状态栏、导航栏、ListTile高度分别为24、56、56 ,适配IphoneX 出错
      //   height: MediaQuery.of(context).size.height-24-56-56 ,//400,
      //   child: ListView.builder(
      //     itemCount: 100,
      //     itemExtent: 50.0,
      //     itemBuilder: (BuildContext context, int index) {
      //       return ListTile(leading: Icon(Icons.image), title: Text("$index"));
      //     }),
      // ),
      Expanded(
        child: ListView.builder(
            itemCount: 100,
            itemExtent: 50.0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  leading: Icon(Icons.image), title: Text("$index"));
            }),
      ),
    ]);

    //下划线widget预定义以供复用。
    // Widget divider1=Divider(color: Colors.blue,);
    // Widget divider2=Divider(color: Colors.green);
    // return ListView.separated(
    //     itemBuilder: (BuildContext context, int index) {
    //       return ListTile(leading: Icon(Icons.image), title: Text("$index"));
    //     },
    //     separatorBuilder: (BuildContext context, int index) {
    //       return index % 2 == 0
    //           ? divider1
    //           : divider2;
    //     },
    //     itemCount: 100);
    // return InfinitedListView();
  }
}

// 无限加载列表
class InfinitedListView extends StatefulWidget {
  InfinitedListView({Key key}) : super(key: key);

  @override
  _InfinitedListViewState createState() => _InfinitedListViewState();
}

class _InfinitedListViewState extends State<InfinitedListView> {
  static const loadingTag = "##loading##";
  var _words = <String>[loadingTag];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(title: Text("商品列表")),
        Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  if (_words[index] == loadingTag) {
                    if (_words.length - 1 < 100) {
                      _retrieveData();
                      return Container(
                        padding: const EdgeInsets.all(15.0),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15.0),
                        child:
                            Text("没有更多了", style: TextStyle(color: Colors.grey)),
                      );
                    }
                  }
                  return ListTile(
                      leading: Icon(Icons.image), title: Text(_words[index]));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: .0);
                },
                itemCount: _words.length)),
      ],
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {});
    });
  }
}

class GridViewTest extends StatefulWidget {
  GridViewTest({Key key}) : super(key: key);

  @override
  _GridViewTestState createState() => _GridViewTestState();
}

class _GridViewTestState extends State<GridViewTest> {
  @override
  Widget build(BuildContext context) {
    // return GridView.count(
    //   crossAxisCount: 3,
    //   // crossAxisSpacing: 10.0,
    //   childAspectRatio: 1.0,
    //   children: <Widget>[
    // Icon(Icons.ac_unit),
    // Icon(Icons.airport_shuttle),
    // Icon(Icons.all_inclusive),
    // Icon(Icons.beach_access),
    // Icon(Icons.cake),
    // Icon(Icons.free_breakfast),
    //   ],
    // );
    // return GridView(
    //   padding: EdgeInsets.zero,
    //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: 120,
    //     childAspectRatio: 1.0,
    //   ),
    //   children: <Widget>[
    // Icon(Icons.ac_unit),
    // Icon(Icons.airport_shuttle),
    // Icon(Icons.all_inclusive),
    // Icon(Icons.beach_access),
    // Icon(Icons.cake),
    // Icon(Icons.free_breakfast),
    //   ],
    // );
    return GridView.extent(
      maxCrossAxisExtent: 120.0,
      childAspectRatio: 1.0,
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    );
  }
}

class InfinitedGridView extends StatefulWidget {
  InfinitedGridView({Key key}) : super(key: key);

  @override
  _InfinitedGridViewState createState() => _InfinitedGridViewState();
}

class _InfinitedGridViewState extends State<InfinitedGridView> {
  List<IconData> _icons = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
        ),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          if (index == _icons.length - 1 && _icons.length < 200) {
            _retrieveIcons();
          }
          return Icon(_icons[index]);
        });
  }

  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airline_seat_flat,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast,
        ]);
      });
    });
  }
}

class ScrollControllerTestRoute extends StatefulWidget {
  ScrollControllerTestRoute({Key key}) : super(key: key);

  @override
  _ScrollControllerTestRouteState createState() =>
      _ScrollControllerTestRouteState();
}

class _ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  ScrollController _controller = new ScrollController();
  bool showTopButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener(() {
      if (_controller.offset < 1000 && showTopButton) {
        setState(() {
          showTopButton = false;
        });
      } else if (_controller.offset >= 1000 && showTopButton == false) {
        setState(() {
          showTopButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("滚动控制"),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(title: Text("$index"));
          },
          itemCount: 100,
          itemExtent: 50.0,
          controller: _controller,
        ),
      ),
      floatingActionButton: !showTopButton
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              }),
    );
  }
}

class CustomScrollViewTestRoute extends StatelessWidget {
  const CustomScrollViewTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background:
                  Image.asset("images/avatar_bg.jpg", fit: BoxFit.cover),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid(
                delegate: new SliverChildBuilderDelegate(
                  (context, index) {
                    return new Container(
                      alignment: Alignment.center,
                      color: Colors.cyan[100 * (index % 9)],
                      child: Text("grid item $index"),
                    );
                  },
                  childCount: 20,
                ),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0,
                )),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text("list item $index"),
                );
              },
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}

class WillPopScopeTestRoute extends StatefulWidget {
  @override
  WillPopScopeTestRouteState createState() {
    return new WillPopScopeTestRouteState();
  }
}

class WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("测试")),
      body: new WillPopScope(
          onWillPop: () async {
            if (_lastPressedAt == null ||
                DateTime.now().difference(_lastPressedAt) >
                    Duration(seconds: 1)) {
              //两次点击间隔超过1秒则重新计时
              _lastPressedAt = DateTime.now();
              return false;
            }
            return true;
          },
          child: Container(
            alignment: Alignment.center,
            child: Text("1秒内连续按两次返回键退出"),
          )),
    );
  }
}

/// 数据共享

class ShareDataWidget extends InheritedWidget {
  final int data; //需要在子树中共享的数据，保存点击次数

  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  static ShareDataWidget of(BuildContext context) {
    /// 而当调用的是 ancestorInheritedElementForWidgetOfExactType()时，
    /// 由于没有注册依赖关系，所以之后当InheritedWidget发生变化时，
    /// 就不会更新相应的子孙Widget。
    return context.dependOnInheritedWidgetOfExactType(aspect: ShareDataWidget);
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.data != data;
  }
}

/// 组件间数据共享
class TestWidget extends StatefulWidget {
  TestWidget({Key key}) : super(key: key);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  InheritedWidgetTestRoute({Key key}) : super(key: key);

  @override
  _InheritedWidgetTestRouteState createState() =>
      _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TestWidget(),
            ),
            RaisedButton(
                child: Text("Increment"),
                onPressed: () {
                  setState(() {
                    ++count;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
