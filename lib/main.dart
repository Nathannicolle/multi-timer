import 'dart:html';

import 'package:flutter/material.dart';
import 'package:multi_timer/composant/AddTimer.dart';
import 'package:multi_timer/pages/groups.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Multi-Timer Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final int _duration = 10;
  final CountDownController _controller = CountDownController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: GFAppBar (
    leading:  GFIconButton(
    icon: Icon(
      Icons.message,
      color: Colors.white,
    ),
    onPressed: () {},
    type: GFButtonType.transparent,
    ),
    title: Text("GF Appbar"),
    actions: <Widget>[
    GFIconButton(
    icon: Icon(
    Icons.favorite,
    color: Colors.white,
    ),
    onPressed: () {},
    type: GFButtonType.transparent,
    ),
    ],
    ),
      body: Center (
        child: CircularCountDownTimer(width: 100, height: 100, duration: 60, fillColor: Colors.red, ringColor: Colors.blue,autoStart: true),

          ),

    );
  }

}
