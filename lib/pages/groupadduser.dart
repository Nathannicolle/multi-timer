import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:multi_timer/pages/groupusers.dart';
import 'package:searchfield/searchfield.dart';

import '../main.dart';
import 'ConnectPage.dart';
import 'groups.dart';

class groupadduser extends StatefulWidget {

  const groupadduser({Key? key, required this.title, required this.idGroup, required this.listUsersNom, required this.listUsersPrenom, required this.listUsersEmail, required this.listUsers}) : super(key: key);

  static const String routeName = "/groupadduser";

  final String title;
  final String idGroup;
  final List listUsersEmail;
  final List listUsersNom;
  final List listUsersPrenom;
  final List listUsers;

  @override
  State<groupadduser> createState() => groupadduserState();
}

class groupadduserState extends State<groupadduser> {

  int _selectedIndex = 3;
  int nbUser = 0;
  List listUserNames = ['David', 'George'];
  final groupUserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.listUsers);
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
              SearchField(
                hint: "Nom de l'utilisateur",
                searchStyle: TextStyle(color: Colors.white),
                searchInputDecoration: InputDecoration(
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
                ),
                marginColor: Colors.blue,
                maxSuggestionsInViewPort: 6,
                suggestionsDecoration: BoxDecoration(
                  color: Color.fromRGBO(57, 57, 57, 1),
                ),
                suggestions: widget.listUsers.map((e) =>
                    SearchFieldListItem(
                    e,
                    item: e,
                    child: Text(e, style: TextStyle(color: Colors.white)),
                    ),
                )
                .toList(),
                controller: groupUserController,
              ),

              GFButton(
                  onPressed: () => {
                    print(groupUserController.value.text),
                    nbUser = 0,
                    widget.listUsers.forEach((element) {
                      if(groupUserController.value.text.isEmpty) {

                      } else if(groupUserController.value.text == element) {
                        FirebaseFirestore.instance.collection('Groups').doc(widget.idGroup).collection('Utilisateurs').add({
                          'email': widget.listUsersEmail[nbUser],
                          'firstname': widget.listUsersPrenom[nbUser],
                          'lastname': widget.listUsersNom[nbUser],
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => groupusers(title: '', idGroup: widget.idGroup)),
                        );
                      }
                      nbUser++;
                    }),

                  },
                  text:"Ajouter",
                  color: Colors.green,
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