import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomeChannelPage extends StatefulWidget {
  MyHomeChannelPage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomeChannelPage> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  String _batteryLevel = 'Unknown battery level.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            onPressed: _getBatteryLevel,
            child: Text('Get Battery Level'),
          ),
          Text(_batteryLevel),
        ],
      ),
    );
  }

  Future<Null> _getBatteryLevel() async {
    print("object");
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result %.';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    _batteryLevel = "sjaldksfkasld";
    print(batteryLevel);
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
