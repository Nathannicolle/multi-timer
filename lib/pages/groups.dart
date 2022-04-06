import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class groups extends StatefulWidget {

  const groups({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<groups> createState() => groupsState();
}

class groupsState extends State<groups> {

  @override
  Widget build(BuildContext context) {

    /*TextButton( // sur le main
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const groups(title: "title"))), child: Text("Les groupes")
    ),*/

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des groupes'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(

        child: GridView.count(

          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[

            Container(
              padding: const EdgeInsets.all(8),
              child: const Text("He'd have you all unravel at the", textAlign: TextAlign.center),
              color: Colors.green[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text("He'd have you all unravel at the"),
              color: Colors.green[100],
            ),

            GFCard(
              titlePosition: GFPosition.end,
              title: GFListTile(
                title: Text('Groupe Alpha1'),
              ),
              content: Text('Groupe Alpha2'),
              margin: EdgeInsets.symmetric(horizontal: 150, vertical: 0),
              padding: EdgeInsets.symmetric(vertical: 10),
            ),

          ],

        ),


      ),
    );

  }
  
}