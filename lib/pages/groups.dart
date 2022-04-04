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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des groupes'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(

        child: GFCard(
          boxFit: BoxFit.cover,
          image: Image.asset('your asset image'),
          title: GFListTile(
            avatar: GFAvatar(
              backgroundImage: AssetImage('your asset image'),
            ),
            title: Text('Card Title'),
            subTitle: Text('Card Sub Title'),
          ),
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

      ),
    );

  }
  
}