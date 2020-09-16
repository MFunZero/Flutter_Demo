import 'package:edu_flutter/models/User.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
 
class WebSocketRoute extends StatefulWidget {
  WebSocketRoute({Key key}) : super(key: key);

  @override
  _WebSocketRouteState createState() => _WebSocketRouteState();
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  TextEditingController _controller = new TextEditingController();
  IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel = new IOWebSocketChannel.connect("ws://echo.websocket.org");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebSocket(内容回显)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: "Send a message"),
              ),
            ),
            StreamBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  _text = "网络错误";
                } else if (snapshot.hasData) {
                  _text = "echo:" + snapshot.data;
                }
                return new Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(_text),
                );
              },
              stream: channel.stream,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
    var user = User("Allen", "Hj");
    print(user.toJson());
    var user2 = User.fromJson({"name": "John Smith", "email": "john@example.com"});
    print(user2);
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      print("current platForm is iOS");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    channel.sink.close();
    super.dispose();
  }
}
