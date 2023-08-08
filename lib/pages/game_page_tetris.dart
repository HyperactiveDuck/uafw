import 'package:flutter/material.dart';
import '../tetris.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';

class GamePageTetris extends StatefulWidget {
  const GamePageTetris({super.key});

  @override
  State<GamePageTetris> createState() => _GamePageTetrisState();
}

class _GamePageTetrisState extends State<GamePageTetris> {
  String gameName = 'Tetris';

  goHome() {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 87, 104, 117),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 40, 48, 54),
        centerTitle: true,
        title: Text(
          gameName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: App(),
          ),
          Container(
            height: 50,
            color: const Color.fromARGB(255, 40, 48, 54),
            child: const Center(
              child: Text(
                'Umut OÇAK - Yücel Arda DEMİRCİ - 2023 ©',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
