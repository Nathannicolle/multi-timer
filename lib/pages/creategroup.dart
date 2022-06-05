import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

import '../main.dart';
import 'ConnectPage.dart';
import 'groups.dart';

class creategroup extends StatefulWidget {

  const creategroup({Key? key, required this.title}) : super(key: key);

  static const String routeName = "/creategroup";

  final String title;

  @override
  State<creategroup> createState() => creategroupState();
}

class creategroupState extends State<creategroup> {

  int _selectedIndex = 3;
  final libelleController = TextEditingController();

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
        body: Center(

          child: Column(
            children: [
              Form(
                child: Wrap(
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white60),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey.shade200,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.supervised_user_circle, color: Colors.white60),
                        filled: true,
                        hintText: 'Nom du groupe',
                      ),
                      style: TextStyle(color: Colors.white),
                      autofocus: true,
                      controller: libelleController,
                    ),
                    GFButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('Groups').add({
                          'libelle': libelleController.value.text,
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const groups(title: '')),
                        );
                      },
                      text:"Ajouter",
                      color: Colors.green,
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