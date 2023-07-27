import 'package:flutter/material.dart';
import 'package:uafw/snakegame.dart';

class GamePageSnake extends StatefulWidget {
  const GamePageSnake({super.key});

  @override
  State<GamePageSnake> createState() => _GamePageSnakeState();
}

class _GamePageSnakeState extends State<GamePageSnake> {
  String gameName = 'Yılan Oyunu';

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
          Expanded(
            flex: 12,
            child: Center(
              child: Container(
                  width: 600,
                  height: 855,
                  color: Colors.red,
                  child: const SnakeGame()),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 40, 48, 54),
              child: const Center(
                child: Text(
                  'Umut OÇAK - Yücel Arda DEMİRCİ - 2023 ©',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
