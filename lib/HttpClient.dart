import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class HttpTestRoute extends StatefulWidget {
  HttpTestRoute({Key key}) : super(key: key);

  @override
  _HttpTestRouteState createState() => _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文件操作"),
      ),
      body: ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text(_loading ? "正在请求...":"加载数据"),
            onPressed: _loading ? null: () async {
            setState(() {
              _loading = !_loading;
              _text = "正在请求...";
            });
            try {
              HttpClient httpClient = new HttpClient();
              HttpClientRequest request = await httpClient.getUrl(Uri.parse("https://www.baidu.com"));
              request.headers.add("user-agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
              HttpClientResponse response = await request.close();
              _text = await response.transform(utf8.decoder).join();
              print(response.headers);
              httpClient.close();
            } catch (e) {
              _text = "请求失败: $e";
            } finally {
              setState(() {
                _loading = false;
              });
            }
          }),
          Container(
            width: MediaQuery.of(context).size.width-50.0,
            child: Text(_text.replaceAll(new RegExp(r"\s"),"")),
          )
        ],
      )),
    ),);
  }
}
