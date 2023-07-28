import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uafw/tetris_controls_guilde.dart';

class GameInfo extends StatefulWidget {
  const GameInfo({super.key});

  @override
  State<GameInfo> createState() => _GameInfoState();
}

class _GameInfoState extends State<GameInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 48, 54),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Butona tıkladığınızda karşınza seçilmiş olan 2 oyundan biri çıkacak.\n"Başla" butonuna tıkladığınıdada oyun başlayacak.\nOyunu her gün yalnızca 15 dakika kadar oynayabilirsiniz.\nOyundaki skorlarınız sistem tarafından kaydedilecek ve deney için kullanılacaktır',
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
                      childCurrent: const GameInfo(),
                      child: const TetrisController(),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 21, 26, 29),
                ),
                height: 60,
                width: 150,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Devam Et',
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
    );
  }
}
