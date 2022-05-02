import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_timer/main.dart';
import 'package:multi_timer/pages/ConnectPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key, required this.title}) : super(key: key);

  static const String routeName = "/SignupPage";

  final String title;

  @override
  _SignupPageState createState() => _SignupPageState();
}

/// // 1. After the page has been created, register it with the app routes
/// routes: <String, WidgetBuilder>{
///   UserPage.routeName: (BuildContext context) => UserPage(title: "UserPage"),
/// },
///
/// // 2. Then this could be used to navigate to the page.
/// Navigator.pushNamed(context, UserPage.routeName);
///

class _SignupPageState extends State<SignupPage> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  int _selectedIndex = 4;
  String itemValue = '';

  String email = '';
  String password = '';

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
                onPressed: () =>
                {
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
            color: Colors.black,
            child: Column(
                children: <Widget>[
                Text("S'inscrire",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 30)),
            Form(
              child: FractionallySizedBox(
                  child: Wrap(
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                  TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                  fillColor: Colors.grey,
                  filled: true,
                  hintText: 'Email'),
              autofocus: true,
              initialValue: '',
              onChanged: (value) {
                email = value.toString().trim();
              },
            ),
            /*TextFormField(
                          decoration: InputDecoration(
                              fillColor: Colors.grey,
                              filled: true,
                              hintText: 'Firstname'),
                          initialValue: '',
                          onChanged: (value) {
                            itemValue = value;
                          }),
                      TextFormField(
                          decoration: InputDecoration(
                              fillColor: Colors.grey,
                              filled: true,
                              hintText: 'Lastname'),
                          initialValue: '',
                          onChanged: (value) {
                            itemValue = value;
                          }),*/
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                  fillColor: Colors.grey,
                  filled: true,
                  hintText: 'Password'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              initialValue: '',
              onChanged: (value) {
                password = value;
              },
            ),
            ElevatedButton(
                onPressed: () => {
                  _auth.createUserWithEmailAndPassword(email: email, password: password),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Sucessfully Register.You Can Login Now'),
                      ),
                      duration: Duration(seconds: 5),
                    ),
                  ),
                  Navigator.of(context).pop()
                },
                child: Text('Register')
            )
    ]))),
    Text('ou', style: TextStyle(color: Colors.grey)),
    TextButton(
    onPressed: () => {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    const ConnectPage(title: '')))
    },
    child: Text('Se connecter'))
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
    onTap: _onItemTapped
    ,
    )
    );
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
