import 'dart:developer';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final Stream<QuerySnapshot> _groupsStream = FirebaseFirestore.instance.collection('Groups').orderBy('libelle').snapshots();
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

        child: StreamBuilder<QuerySnapshot>(
          stream: _groupsStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return GridView(

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              children:
                snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return _listGroups(data, document);
                }).toList(),
            );

          },
        ),

        /*GridView.builder(

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: listGroupNames.length,
          itemBuilder: (context, index) {
            final item = listGroupNames[index];

            return _listGroups(item);
          },

          //mainAxisSpacing: 10,
          /*padding: EdgeInsets.all(20),
          crossAxisCount: 2,
          children: <Widget>[
            _listGroups(),
          ],*/

        ),*/


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

  Widget _listGroups(Map<String, dynamic> group, DocumentSnapshot document) {

    return GestureDetector(
      onLongPress: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Option ' + group['libelle'].toString(), style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Modifier le nom du groupe :', style: TextStyle(color: Colors.white)),
              GFButton(
                onPressed: () => {_popupModifyGroup(group, document)},
                text:"Modifier",
                color: Colors.blue,
              ),
              Text('Supprimer le groupe :', style: TextStyle(color: Colors.white)),
              GFButton(
                onPressed: () => {_popupSupprGroup(group, document)},
                text:"Supprimmer",
                color: Colors.red,
              ),
            ],
          ),
          backgroundColor: Color.fromRGBO(57, 57, 57, 1),
        ),
      ),
      child: GFCard(
        title: GFListTile(
          title: Text(''),
          //subTitle: Text(''),
        ),
        color: Color.fromRGBO(57, 57, 57, 1),
        content: Text(group['libelle'], style: TextStyle(color: Colors.white)),
        buttonBar: GFButtonBar(
          children: <Widget>[
            GFButton(
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => groupusers(title: '', idGroup: document.id)),
              );},
              text: 'info',
              icon: Icon(Icons.info, color: Colors.white),
            ),
          ],
        ),
      ),
    );

  }

  Future<String?> _popupModifyGroup(Map<String, dynamic> group, DocumentSnapshot document) {
    final libelleController = TextEditingController(text: group['libelle']);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Modifier le nom du groupe', style: TextStyle(color: Colors.white)),
        content: TextField(
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
        actions: <Widget>[
          GFButton(
            onPressed: () => Navigator.pop(context, 'Non'),
            text:"Annuler",
            color: Colors.red,
          ),
          GFButton(
            onPressed: () => {
              FirebaseFirestore.instance.collection('Groups').doc(document.id).update({
                'libelle': libelleController.value.text,
              }),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const groups(title: '')),
              ),
            },
            text:"Modifier",
            color: Colors.blue,
          ),
        ],
        backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      ),
    );
  }

  Future<String?> _popupSupprGroup(Map<String, dynamic> group, DocumentSnapshot document) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Êtes-vous sûr de vouloir suprimmer le groupe ' + group['libelle'].toString() + ' ?', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GFButton(
                  onPressed: () => Navigator.pop(context, 'Non'),
                  text:"Non",
                  color: Colors.blue,
                ),
                GFButton(
                  onPressed: () => {
                    FirebaseFirestore.instance.collection('Groups').doc(document.id).delete(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const groups(title: '')),
                    ),
                  },
                  text:"Oui",
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(57, 57, 57, 1),
      ),
    );
  }
  
}