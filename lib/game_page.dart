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
      backgroundColor: const Color.fromARGB(255, 87, 104, 117),
      appBar: AppBar(
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
                child: const Text(
                  'Oyun',
                ),
              ),
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
