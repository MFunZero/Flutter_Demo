import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  // final String text;
  const RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    print(args);
    // print(text);
    return MaterialApp(
      title: "注册",
      home: Scaffold(
        body: RegisterContent(),
        appBar: AppBar(
          elevation: 0,
          // brightness: Brightness.light,
          // bottomOpacity: 0.0,
          title: Text(
            "注册",
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.grey,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ),
      // theme: ThemeData(primarySwatch: Colors.blue),
      // routes: ,
    );
  }
}

class RegisterContent extends StatelessWidget {
  const RegisterContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 100, left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: "请输入手机号",
                prefixIcon: Icon(Icons.mobile_screen_share),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: "请输入密码",
                prefixIcon: Icon(Icons.lock),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: "请再次输入密码",
                prefixIcon: Icon(Icons.lock),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Container(
              height: 50,
              margin: EdgeInsets.only(top: 60, left: 20, right: 20),
              child: RaisedButton(
                  textColor: Colors.white,
                  child: Text("注册"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: Colors.blue,
                  onPressed: () {
                    debugDumpRenderTree();
                  }))
        ],
      ),
    );
  }
}
