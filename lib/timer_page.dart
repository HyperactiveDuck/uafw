import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int minutes = 15;
  int seconds = 0;

  Timer? _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (minutes == 0 && seconds == 0) {
        _showTimeUpAlert();
        _logoutAndNavigateToLoginPage();
        return;
      }

      setState(() {
        if (seconds == 0) {
          minutes--;
          seconds = 59;
        } else {
          seconds--;
        }
      });
    });
  }

  void _showTimeUpAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time\'s up!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _logoutAndNavigateToLoginPage() {
    // Code to logout the user using Firebase
    // Replace this with the actual code to logout the user from Firebase.

    // After logging out, navigate to the LoginPage
    Navigator.pushReplacementNamed(
        context, '/login'); // '/login' is the route name of the LoginPage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countdown Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$minutes:${seconds.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startTimer,
              child: Text('Start Timer'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
