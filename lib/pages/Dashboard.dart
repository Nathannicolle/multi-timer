import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.title}) : super(key: key);

  static const String routeName = "/ConnectPage";

  final String title;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

/// // 1. After the page has been created, register it with the app routes
/// routes: <String, WidgetBuilder>{
///   UserPage.routeName: (BuildContext context) => UserPage(title: "UserPage"),
/// },
///
/// // 2. Then this could be used to navigate to the page.
/// Navigator.pushNamed(context, UserPage.routeName);
///

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 6;
  String itemValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Connecté"),
      ),
    );
  }
}
