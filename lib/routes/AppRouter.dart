import 'package:flutter/material.dart';
import 'package:multi_timer/main.dart';
import 'package:multi_timer/pages/ConnectPage.dart';

class AppRouter {
  static Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    '/': (BuildContext context)=>MyHomePage(title: 'Home'),
    ConnectPage.routeName: (BuildContext context) => ConnectPage(title: "ConnectPage"),
  };

  static getRoutes() => _routes;
}