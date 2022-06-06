import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  const groupusers({Key? key, required this.title, required this.idGroup}) : super(key: key);

  static const String routeName = "/groupusers";

  final String title;
  final String idGroup;

  @override
  State<groupusers> createState() => groupusersState();
}

class groupusersState extends State<groupusers> {

  int _selectedIndex = 3;
  List listUserNames = ['Louka-Fauvel', 'Nathannicolle', 'papi-luc', ['aeaze', 'zaea']];
  List listGroupUsersEmail = [];
  List listGroupUsersNom = [];
  List listGroupUsersPrenom = [];
  List listUsersEmail = [];
  List listUsersNom = [];
  List listUsersPrenom = [];
  List listUsers = [];

  Future<QuerySnapshot?> getdataGroupUsers() async{
    return FirebaseFirestore.instance.collection('Groups').doc(widget.idGroup).collection('Utilisateurs').orderBy('firstname').get().then((QuerySnapshot? querySnapshot){
      querySnapshot!.docs.forEach((doc) {
        listGroupUsersEmail.add(doc['email']);
        listGroupUsersNom.add(doc['lastname']);
        listGroupUsersPrenom.add(doc['firstname']);
      });
      //print(listGroupUsersEmail);
      getdataUsers();
    });
  }

  Future<QuerySnapshot?> getdataUsers() async{
    return FirebaseFirestore.instance.collection('Utilisateurs').orderBy('firstname').get().then((QuerySnapshot? querySnapshot){
      querySnapshot!.docs.forEach((doc) {
        if(listGroupUsersEmail.isEmpty) {
          listUsersEmail.add(doc['email']);
          listUsersNom.add(doc['lastname']);
          listUsersPrenom.add(doc['firstname']);
        } else if(listGroupUsersEmail.length == querySnapshot.docs.length) {

        } else {
          listGroupUsersEmail.forEach((element) {
            if(doc['email']!= element) {
              listUsersEmail.add(doc['email']);
              listUsersNom.add(doc['lastname']);
              listUsersPrenom.add(doc['firstname']);
            }
          });
        }
      });
      getListUsers();
    });
  }

  void getListUsers() {
    int nbUser = 0;
    listUsersNom.forEach((element) {
      listUsers.add(listUsersPrenom[nbUser] + ' ' + element);
      nbUser++;
    });
  }

  @override
  Widget build(BuildContext context) {
    getdataGroupUsers();
    final Stream<QuerySnapshot> _groupUsersStream = FirebaseFirestore.instance.collection('Groups').doc(widget.idGroup).collection('Utilisateurs').orderBy('firstname').snapshots();
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
            MaterialPageRoute(builder: (context) => groupadduser(title: '', idGroup: widget.idGroup, listUsersNom: listUsersNom, listUsersPrenom: listUsersPrenom, listUsersEmail: listUsersEmail, listUsers: listUsers)),
          );},
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
        body: Center(

          child: StreamBuilder<QuerySnapshot>(
            stream: _groupUsersStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return _listUsers(data, document);
                }).toList(),
              );

            },
          ),

          /*Column(
            children: [
              _listUsers(),

            ],
          )*/


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

  Widget _listUsers(Map<String, dynamic> user, DocumentSnapshot document) {
    return GFListTile(
      title:Text(user['firstname'] + ' ' + user['lastname'], style: TextStyle(color: Colors.white)),
      color: Color.fromRGBO(57, 57, 57, 1),
      icon: IconButton(
        iconSize: 30,
        color: Colors.transparent,
        icon: Icon(Icons.cancel, color: Colors.white),
        onPressed: () => {_popupSupprGroupUser(user, document)},
      ),
    );

  }

  Future<String?> _popupSupprGroupUser(Map<String, dynamic> user, DocumentSnapshot document) {
    print(document.id);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Êtes-vous sûr de vouloir suprimmer ' + user['firstname'] + ' ' + user['lastname'] + ' du groupe ?', style: TextStyle(color: Colors.white)),
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
                    FirebaseFirestore.instance.collection('Groups').doc(widget.idGroup).collection('Utilisateurs').doc(document.id).delete(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => groupusers(title: '', idGroup: widget.idGroup)),
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