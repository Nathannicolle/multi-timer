import 'package:flutter/material.dart';
import 'package:multi_timer/main.dart';
import 'package:multi_timer/pages/ConnectPage.dart';
import 'package:multi_timer/pages/SignupPage.dart';

class AppRouter {
  static Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    '/': (BuildContext context)=>MyHomePage(title: 'Home'),
    ConnectPage.routeName: (BuildContext context) => ConnectPage(title: "ConnectPage"),
    SignupPage.routeName: (BuildContext context) => SignupPage(title: "Signup")
  };

  static getRoutes() => _routes;
}