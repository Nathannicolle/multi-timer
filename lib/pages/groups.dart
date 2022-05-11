import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:multi_timer/main.dart';

import 'ConnectPage.dart';
import 'creategroup.dart';
import 'groupusers.dart';

class groups extends StatefulWidget {

  const groups({Key? key, required this.title}) : super(key: key);

  static const String routeName = "/groups";

  final String title;

  @override
  State<groups> createState() => groupsState();
}

class groupsState extends State<groups> {

  int _selectedIndex = 3;
  List listGroupNames = ["Alpha", "Beta", "Omega", "Delta"];

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const creategroup(title: '')),
        );},
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: Center(

        child: GridView.count(

          //mainAxisSpacing: 10,
          padding: EdgeInsets.all(20),
          crossAxisCount: 2,
          children: <Widget>[

            GFCard(
              title: GFListTile(
                title: Text(''),
                //subTitle: Text(''),
              ),
              margin: EdgeInsets.symmetric(vertical: 150, horizontal: 50),
              color: Color.fromRGBO(57, 57, 57, 1),
              content: Text("Groupe Alpha", style: TextStyle(color: Colors.white)),
              buttonBar: GFButtonBar(
                children: <Widget>[
                  GFButton(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const groupusers(title: '')),
                    );},
                    text: 'info',
                    icon: Icon(Icons.info, color: Colors.white),
                  ),
                ],
              ),
            ),

            GFCard(
              title: GFListTile(
                title: Text(''),
                //subTitle: Text(''),
              ),
              margin: EdgeInsets.symmetric(vertical: 150, horizontal: 50),
              color: Color.fromRGBO(57, 57, 57, 1),
              content: Text("Groupe Beta", style: TextStyle(color: Colors.white)),
              buttonBar: GFButtonBar(
                children: <Widget>[
                  GFButton(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const groupusers(title: '')),
                    );},
                    text: 'info',
                    icon: Icon(Icons.info, color: Colors.white),
                  ),
                ],
              ),
            ),

            GFCard(
              title: GFListTile(
                title: Text(''),
                //subTitle: Text(''),
              ),
              margin: EdgeInsets.symmetric(vertical: 150, horizontal: 50),
              color: Color.fromRGBO(57, 57, 57, 1),
              content: Text("Groupe Omega", style: TextStyle(color: Colors.white)),
              buttonBar: GFButtonBar(
                children: <Widget>[
                  GFButton(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const groupusers(title: '')),
                    );},
                    text: 'info',
                    icon: Icon(Icons.info, color: Colors.white),
                  ),
                ],
              ),
            ),

            GFCard(
              title: GFListTile(
                title: Text(''),
                //subTitle: Text(''),
              ),
              margin: EdgeInsets.symmetric(vertical: 150, horizontal: 50),
              color: Color.fromRGBO(57, 57, 57, 1),
              content: Text("Groupe Delta", style: TextStyle(color: Colors.white)),
              buttonBar: GFButtonBar(
                children: <Widget>[
                  GFButton(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const groupusers(title: '')),
                    );},
                    text: 'info',
                    icon: Icon(Icons.info, color: Colors.white),
                  ),
                ],
              ),
            ),
            _listGroups(),
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

  Widget _listGroups() {

    return Column(
      children: List.generate(listGroupNames.length, (index) =>
          GFCard(
            title: GFListTile(
              title: Text(''),
              //subTitle: Text(''),
            ),
            margin: EdgeInsets.symmetric(vertical: 150, horizontal: 50),
            color: Color.fromRGBO(57, 57, 57, 1),
            content: Text("Groupe " + listGroupNames[index].toString(), style: TextStyle(color: Colors.white)),
            buttonBar: GFButtonBar(
              children: <Widget>[
                GFButton(
                  onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const groupusers(title: '')),
                  );},
                  text: 'info',
                  icon: Icon(Icons.info, color: Colors.white),
                ),
              ],
            ),
          ),
      ),
    );

  }
  
}