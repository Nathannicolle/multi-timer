import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/bottom_sheet/gf_bottom_sheet.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:multi_timer/pages/groups.dart';
import 'package:multi_timer/pages/ConnectPage.dart';
import 'package:multi_timer/routes/AppRouter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: AppRouter.getRoutes(),
      debugShowCheckedModeBanner: false,
      title: 'Circular Countdown Timer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Circular Countdown Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _duration = 10;
  final CountDownController _controller = CountDownController();
  final currentHour = DateTime.now().hour;
  int _selectedIndex = 0;

  showHourMessage() {
    if (currentHour >= 0 && currentHour <= 7) {
      return const Text('Bonne nuit',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 30));
    } else if (currentHour <= 23 && currentHour >= 18) {
      return const Text('Bonsoir',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 30));
    } else {
      return const Text('Bonjour',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 30));
    }
  }

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
                  onPressed: () => { Navigator.pushNamed(context, ConnectPage.routeName) },
                )
              ]),
        ),
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        body: Center(
            child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                height: 50,
                child: Text("Accueil",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 30)),
              )
            ]),
            SizedBox(
              height: 60,
              child: showHourMessage(),
            ),
            CircularCountDownTimer(
              // Countdown duration in Seconds.
              duration: _duration,

              // Countdown initial elapsed Duration in Seconds.
              initialDuration: 0,

              // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
              controller: _controller,

              // Width of the Countdown Widget.
              width: MediaQuery.of(context).size.width / 2,

              // Height of the Countdown Widget.
              height: MediaQuery.of(context).size.height / 2,

              // Ring Color for Countdown Widget.
              ringColor: Colors.grey[300]!,

              // Ring Gradient for Countdown Widget.
              ringGradient: null,

              // Filling Color for Countdown Widget.
              fillColor: Colors.red[500]!,

              // Filling Gradient for Countdown Widget.
              fillGradient: null,

              // Background Color for Countdown Widget.
              backgroundColor: Colors.blue[500],

              // Background Gradient for Countdown Widget.
              backgroundGradient: null,

              // Border Thickness of the Countdown Ring.
              strokeWidth: 20.0,

              // Begin and end contours with a flat edge and no extension.
              strokeCap: StrokeCap.round,

              // Text Style for Countdown Text.
              textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),

              // Format for the Countdown Text.
              textFormat: CountdownTextFormat.S,

              // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
              isReverse: false,

              // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
              isReverseAnimation: false,

              // Handles visibility of the Countdown Text.
              isTimerTextShown: true,

              // Handles the timer start.
              autoStart: false,

              // This Callback will execute when the Countdown Starts.
              onStart: () {
                // Here, do whatever you want
                debugPrint('Countdown Started');
              },

              // This Callback will execute when the Countdown Ends.
              onComplete: () {
                // Here, do whatever you want
                debugPrint('Countdown Ended');
              },
            )
          ],
        )),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 30,
            ),
            _button(title: "Start", onPressed: () => _controller.start()),
            const SizedBox(
              width: 10,
            ),
            _button(title: "Pause", onPressed: () => _controller.pause()),
            const SizedBox(
              width: 10,
            ),
            _button(title: "Resume", onPressed: () => _controller.resume()),
            const SizedBox(
              width: 10,
            ),
            _button(
                title: "Restart",
                onPressed: () => _controller.restart(duration: _duration))
          ],
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

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
        child: ElevatedButton(
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.purple),
      ),
      onPressed: onPressed,
    ));
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
