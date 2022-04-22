
import 'package:flutter/material.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key, required this.title}) : super(key: key);

  static const String routeName = "/ConnectPage";

  final String title;

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

/// // 1. After the page has been created, register it with the app routes
/// routes: <String, WidgetBuilder>{
///   UserPage.routeName: (BuildContext context) => UserPage(title: "UserPage"),
/// },
///
/// // 2. Then this could be used to navigate to the page.
/// Navigator.pushNamed(context, UserPage.routeName);
///

class _ConnectPageState extends State<ConnectPage> {
  int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.grey,
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset("assets/img/logo_mini.png",
                  width: 200.0, height: 200.0),
            ),
            actions: [
              IconButton(
                iconSize: 30,
                icon: Icon(Icons.account_circle),
                onPressed: () => {},
              )
            ]),
      ),
      backgroundColor: Color.fromRGBO(18, 18, 18, 1),
      body: Container(
        child: Text("Se connecter",  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 30))
      )
    );
  }
}