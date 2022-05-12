import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:multi_timer/pages/groupadduser.dart';

import '../main.dart';
import 'ConnectPage.dart';
import 'groups.dart';

class groupusers extends StatefulWidget {

  const groupusers({Key? key, required this.title}) : super(key: key);

  static const String routeName = "/groupusers";

  final String title;

  @override
  State<groupusers> createState() => groupusersState();
}

class groupusersState extends State<groupusers> {

  int _selectedIndex = 3;
  List listUserNames = ['Louka-Fauvel', 'Nathannicolle', 'papi-luc'];

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const groupadduser(title: '')),
          );},
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
        body: Center(

          child: Column(
            children: [
              _listUsers(),
            ],
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

   Widget _listUsers() {

    return Column(
      children: List.generate(listUserNames.length, (index) =>
          GFListTile(
            title:Text(listUserNames[index].toString(), style: TextStyle(color: Colors.white)),
            color: Color.fromRGBO(57, 57, 57, 1),
            icon: IconButton(
              iconSize: 30,
              color: Colors.transparent,
              icon: Icon(Icons.cancel, color: Colors.white),
              onPressed: () => {},
            ),
          ),
      ),
    );

  }

}