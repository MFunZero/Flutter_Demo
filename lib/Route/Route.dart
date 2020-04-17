import 'package:edu_flutter/Login/Register.dart';
import 'package:edu_flutter/Login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Map routes = {
  '/': (context) => LoginPage(),
  // '/form': (context, {arguments}) => FormPage(),
  // '/search': (context, {arguments}) => SearchPage(
  //   arguments: arguments,
  // ),
  // '/settings': (context, {arguments}) => SettingsPage(
  //       arguments: arguments,
  //     ),
  // '/appBar': (context) => AppBarDemoPage(),
  // '/net': (context) => NetworkPage(),
  '/register': (context) => RegisterPage(),
};

// 注意，onGenerateRoute只会对命名路由生效。

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
