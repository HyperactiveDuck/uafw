import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String gameName = 'Oyun İsmi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 87, 104, 117),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 48, 54),
        centerTitle: true,
        title: Text(
          gameName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text('Oyun'),
            ),
            width: 600,
            height: 677,
            color: Colors.red,
          ),
          Container(
            child: Center(
              child: Text(
                'Umut OÇAK - Yücel Arda DEMİRCİ - 2023 ©',
                style: TextStyle(color: Colors.white),
              ),
            ),
            height: 50,
            color: const Color.fromARGB(255, 40, 48, 54),
          )
        ],
      ),
    );
  }
}
