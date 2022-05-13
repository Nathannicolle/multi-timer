import 'package:flutter/material.dart';
import 'package:multi_timer/auth/LoadingScreen.dart';
import 'package:multi_timer/auth/auth_guard.dart';
import 'package:multi_timer/auth/authentication.dart';
import 'package:multi_timer/main.dart';
import 'package:multi_timer/pages/ConnectPage.dart';
import 'package:multi_timer/pages/Dashboard.dart';
import 'package:multi_timer/pages/SignupPage.dart';

class AppRouter extends StatelessWidget{
  /*static Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    '/': (BuildContext context)=>MyHomePage(title: 'Home'),
    ConnectPage.routeName: (BuildContext context) => ConnectPage(title: "ConnectPage"),
    SignupPage.routeName: (BuildContext context) => SignupPage(title: "Signup"),
    DashboardPage.routeName: (BuildContext context) => DashboardPage(title: '')
  };

  static getRoutes() => _routes;*/

  @override
  Widget build(BuildContext context) {
    return AuthenticationProvider(
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          ConnectPage.routeName: (context) => ConnectPage(title: "ConnectPage"),
          SignupPage.routeName: (context) => SignupPage(title: "Signup Page"),
          DashboardPage.routeName: (context) => _authGuard(context, DashboardPage(title: '')),
        },
      ),
    );
  }

  _authGuard(BuildContext context,Widget page){
    return AuthGuard(
      loadingScreen: LoadingScreen(),
      unauthenticatedHandler: (BuildContext context) => Navigator.of(context).pushReplacementNamed('/login'),
      authenticationStream: AuthenticationProvider.of(context)?.user()
          .map((user) => user == null ? AuthGuardStatus.notAuthenticated : AuthGuardStatus.authenticated),
      child: page,

    );
  }
}