import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:uafw/tetris.dart';

class TetrisController extends StatefulWidget {
  const TetrisController({super.key});

  @override
  State<TetrisController> createState() => TetrisControllerState();
}

class TetrisControllerState extends State<TetrisController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 40, 48, 54),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Title(
                  color: Colors.black,
                  child: const Text(
                    'Tetris Oyunu',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
              const Text(
                'Blokları sağ ve sol yön tuşlatıyla sağa ve sola oynatabilirsiniz\nKlavyenizdeki  "A" tuşu bloğu sola , "D" tuşu bloğu sağa çevirecektir\n Aşağı yön tuşu blokların daha hızlı inmesini sağlar\nKlavyenizdeki boşluk tuşu blokların tek hamlede yere inmesini sağlar.\nOyun süre bitene kadar yansanız bile tekrar başlayacaktır, bütün skorlar kaydedilecektir.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        childCurrent: const TetrisController(),
                        child: const App(),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 21, 26, 29),
                  ),
                  height: 60,
                  width: 100,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Başla',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
