import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:multi_timer/main.dart';

import 'ConnectPage.dart';

class groups extends StatefulWidget {

  const groups({Key? key, required this.title}) : super(key: key);

  static const String routeName = "/groups";

  final String title;

  @override
  State<groups> createState() => groupsState();
}

class groupsState extends State<groups> {

  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {

    /*TextButton( // sur le main
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const groups(title: "title"))), child: Text("Les groupes")
    ),*/

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
      body: Center(

        child: GridView.count(

          //mainAxisSpacing: 10,
          padding: EdgeInsets.all(20),
          crossAxisCount: 2,
          children: <Widget>[

            Container(
              margin: EdgeInsets.all(50),
              child: const Text("He'd have you all unravel at the", textAlign: TextAlign.center),
              color: Colors.green[100],
            ),
            /*Container(
              padding: const EdgeInsets.all(8),
              child: const Text("He'd have you all unravel at the"),
              color: Colors.green[100],
            ),*/

            GFCard(
              titlePosition: GFPosition.end,
              title: GFListTile(
                title: Text('Groupe Alpha1'),
              ),
              content: Text('Groupe Alpha2'),
              //margin: EdgeInsets.symmetric(horizontal: 150, vertical: 0),
              //padding: EdgeInsets.symmetric(vertical: 10),
            ),

            GFCard(
              title: GFListTile(
                title: Text('Card Title'),
                subTitle: Text('Card Sub Title'),
              ),
              padding: const EdgeInsets.all(8),
              content: Text("Some quick example text to build on the card"),
              buttonBar: GFButtonBar(
                children: <Widget>[
                  GFButton(
                    onPressed: () {},
                    text: 'Buy',
                  ),
                  GFButton(
                    onPressed: () {},
                    text: 'Cancel',
                  ),
                ],
              ),
            ),

          ],

        ),


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