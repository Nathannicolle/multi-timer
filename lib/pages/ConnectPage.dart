import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_timer/auth/authentication.dart';
import 'package:multi_timer/main.dart';
import 'package:multi_timer/pages/Dashboard.dart';
import 'package:multi_timer/pages/SignupPage.dart';

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
  String itemValue = '';

  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  static connect(String email,String password,BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      //User is ok, so log in
      AuthenticationProvider.of(context)?.login(credential.user);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Sucessfully login as ' + email),
          ),
          duration: Duration(seconds: 5),
        ),
      );
      Navigator.of(context).pushReplacementNamed('/Dashboard');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()))
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
            child: Column(
          children: <Widget>[
            Text("Se connecter",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 30)),
            Form(
                child: FractionallySizedBox(
                    child: Column(children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.black),
                    fillColor: Colors.grey,
                    filled: true,
                    hintText: 'Login'),
                autofocus: true,
                initialValue: '',
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      fillColor: Colors.grey,
                      filled: true,
                      hintText: 'Password'),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  onChanged: (value) {
                    password = value;
                  }),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => {
                    connect(email, password, context)
                  },
                  child: Text('Connect'))
            ]))),
            Text('ou', style: TextStyle(color: Colors.grey)),
            TextButton(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SignupPage(title: '')))
                    },
                child: Text('S\'inscrire'))
          ],
        )),
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
