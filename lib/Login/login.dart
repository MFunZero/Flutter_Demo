 
import 'package:edu_flutter/Route/Route.dart';
import 'package:flutter/material.dart';
import 'Register.dart';
import 'package:edu_flutter/Route/Route.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "登录",
      home: Scaffold(
        //   appBar: AppBar(
        //   title: Text("登录"),
        //   elevation: 10,
        // ),
        body: LoginHomePage(),
      ),
      theme: ThemeData(primarySwatch: Colors.blue),
      // 路由
      routes: {
        "register": (context) => RegisterPage()
      },
      // routes: {
        // "register": (context){
        //   return RegisterPage(text:ModalRoute.of(context).settings.arguments);
        // }
      // },
      // initialRoute: "/",
      // onGenerateRoute: onGenerateRoute,
    );
  }
}

class LoginHomePage extends StatelessWidget {
  const LoginHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = Image.network("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566225123&di=83f75424937ce7c71c34bb275b72a2b8&imgtype=jpg&er=1&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F0%2F85%2Fd194485054.jpg", 
                        width: 150.0,height: 150.0, fit: BoxFit.cover,);
        return Center(
          child: Container(
            alignment: Alignment.center,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Center(
                  child: Container(
                  width: 150,
                  height: 150,
                  child:  ClipOval( 
                          child:image,
                      )
                ),
                ),
                
                // Container(
                //   //加载网络图片
                //   margin: EdgeInsets.only(top: 70),
                //   child:
              //      Column(
              //       children: <Widget>[ 
              //     Container(
              //       //加载网络图片
              //       height: 120.0,
              //       width: 120.0, 
              //       decoration: BoxDecoration(
              //           color: Colors.yellow,
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(60),
              //           ),
              //           image: DecorationImage(
              //             image: NetworkImage(
              //                 "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566225123&di=83f75424937ce7c71c34bb275b72a2b8&imgtype=jpg&er=1&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2F0%2F85%2Fd194485054.jpg"),
              //             fit: BoxFit.cover,
              //           )),
              //     ),
              //   ],
            //   ),
            // ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "请输入账号",
                  prefixIcon: Icon(Icons.mobile_screen_share),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                obscureText: true,
                // cursorColor: ,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60, left: 10, right: 10),
              height: 50,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Text("登录"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(content: Text("请输入内容"));
                      },
                    );
                  }),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: GestureDetector(
                  child: Text("尚无账户，先去注册",
                  style: TextStyle(color: Colors.blue, fontSize:13),
                  ),
                  onTap: (){
                    print("去注册");
                    Navigator.of(context).pushNamed("register");
                    // Navigator.of(context).pushNamed("register", arguments: "hi");
                    // Navigator.push(context, new MaterialPageRoute(builder: (context) => new RegisterPage()));
                  },
                ),
              ),
            ),
            // Column(
            //   children: <Widget>[
            //     RaisedButton(
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(25)),
            //       child: Text("注册"),
            //       color: Colors.white,
            //       textColor: Colors.white,
            //       onPressed: () {
            //         return ;
            //       }),
            //   ],
            // ),
          ],
        ),
        //ClipOval(child: SizedBox(height: 150, width: 150, child: Image.network("http://attach.bbs.miui.com/forum/201311/24/215347n3kjpxpj3220jj9r.jpg",),
      ),
    );
  }
}
