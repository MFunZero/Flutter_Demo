import 'dart:math';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class FileOperationRoute extends StatefulWidget {
  FileOperationRoute({Key key}) : super(key: key);

  @override
  _FileOperationRouteState createState() => _FileOperationRouteState();
}

class _FileOperationRouteState extends State<FileOperationRoute> {
  int _counter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readCounter().then((value) {
      _counter = value;
    });
  }

  Future<File> _getLocaleFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/counter.text');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocaleFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await (await _getLocaleFile()).writeAsString("$_counter");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("文件操作"),
      ),
      body: Center(child: Text("点击了$_counter 次")),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "Increment",
        child: Icon(Icons.add),
      ),
    );
  }
}
