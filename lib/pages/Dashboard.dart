import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_timer/auth/authentication.dart';
import 'package:multi_timer/composant/timer.dart';
import 'package:multi_timer/pages/ConnectPage.dart';
import 'package:multi_timer/pages/groups.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.title}) : super(key: key);

  static const String routeName = "/Dashboard";

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
  int _selectedIndex = 4;
  String itemValue = '';

  @override
  Widget build(BuildContext context) {
    final userAuth = FirebaseAuth.instance.currentUser?.email;
    String userAuthString = userAuth.toString();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.grey,
              leading: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent)),
                child: Image.asset("assets/img/logo_mini.png",
                    height: 900, width: 900, fit: BoxFit.cover),
                onPressed: () => {
                  Navigator.pushNamed(context, '/')
                },
              ),
              actions: [
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.account_circle),
                  onPressed: () =>
                  {Navigator.pushNamed(context, ConnectPage.routeName)},
                )
              ]),
        ),
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        body: Container(
          child: Center(
            child: Column(
              children:  <Widget>[
                Text("Vous êtes connecté en tant que " + userAuthString, textScaleFactor: 3, style: TextStyle(color: Colors.white)),
                TextButton(onPressed: () => { AuthenticationProvider.of(context)?.logout() }, child: Text("Déconnexion", style: TextStyle(color: Colors.red)), style: ButtonStyle(overlayColor: MaterialStateProperty.all<Color>(Color.fromRGBO(218, 72, 72, .5))))
              ],
            )
          )
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(57, 57, 57, 1),
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timers'),
            BottomNavigationBarItem(
                icon: Icon(Icons.pending_actions), label: 'Trames'),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle), label: 'Groupes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Compte')
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const groups(title: '')),
          );
          break;
        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ConnectPage(title: '')),
          );
          break;
      }
    });
  }
}
