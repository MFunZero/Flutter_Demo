import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FutureBuilderRoute extends StatefulWidget {
  FutureBuilderRoute({Key key}) : super(key: key);

  @override
  _FutureBuilderRouteState createState() => _FutureBuilderRouteState();
}

class _FutureBuilderRouteState extends State<FutureBuilderRoute> {
  Dio _dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dio网络请求"),
      ),
      body: SplitDownloadRoute(),
      // body: Container(
      //   alignment: Alignment.center,
      //   child: FutureBuilder(
      //     future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
      //     builder: (context, AsyncSnapshot snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         Response response = snapshot.data;
      //         if (snapshot.hasError) {
      //           return Text(snapshot.error.toString());
      //         }
      //         return ListView(
      //           children: response.data
      //               .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
      //               .toList(),
      //         );
      //       }
      //       return CircularProgressIndicator();
      //     },
      //   ),
      // ),
    );
  }
}

class SplitDownloadRoute extends StatefulWidget {
  SplitDownloadRoute({Key key}) : super(key: key);

  @override
  _SplitDownloadRouteState createState() => _SplitDownloadRouteState();
}

class _SplitDownloadRouteState extends State<SplitDownloadRoute> {
  List<int> progress = List<int>();
  Dio _dio = new Dio();
  String savePath = "";

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: RaisedButton(
          child: Text("下载"),
          onPressed: () async {
            var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
            var savePath = "./example/HBuilder.9.0.2.macosx_64.dmg";
            await downloadWithChunks(url, savePath, onReceiveProgress:(received, total){
              if (total != -1) {
                print("${(received / total * 100).floor()}%");
              }
            });
          },
        ),
      );
  }

  Future downloadWithChunks(
    url,
    savePath, {
    ProgressCallback onReceiveProgress,
  }) async {
    const firstChunkSize = 102;
    const maxChunk = 3;

    int total = 0;
    var dio = Dio();
    var progress = <int>[];

    createCallBack(no) {
      return (int received, _) {
        progress[no] = received;
        if (onReceiveProgress != null && total != 0) {
          onReceiveProgress(progress.reduce((a, b) => a + b), total);
        }
      };
    }

    Future<Response> downloadChunk(url, start, end, no) async {
      progress.add(0);
      --end;
      return dio.download(url, savePath + "temp$no",
          onReceiveProgress: createCallBack(no),
          options: Options(
            headers: {"range": "bytes=$start-$end"},
          ));
    }

    Future mergeTempFiles(chunk) async {
      File f = File(savePath + "temp0");
      IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend);
      for (int i = 1; i < chunk; ++i) {
        File _f = File(savePath + "temp$i");
        await ioSink.addStream(_f.openRead());
        await _f.delete();
      }
      await ioSink.close();
      await f.rename(savePath);
    }

    Response response = await downloadChunk(url, 0, firstChunkSize, 0);
    if (response.statusCode == 206) {
      total = int.parse(response.headers
          .value(HttpHeaders.contentRangeHeader)
          .split("/")
          .last);
      int reserved = total -
          int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
      int chunk = (reserved / firstChunkSize).ceil() + 1;
      if (chunk > 1) {
        int chunkSize = firstChunkSize;
        if (chunk > maxChunk + 1) {
          chunk = maxChunk + 1;
          chunkSize = (reserved / maxChunk).ceil();
        }
        var futures = <Future>[];
        for (int i = 0; i < maxChunk; ++i) {
          int start = firstChunkSize + i * chunkSize;
          futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
        }
        await Future.wait(futures);
      }
      await mergeTempFiles(chunk);
    }
  }
}
