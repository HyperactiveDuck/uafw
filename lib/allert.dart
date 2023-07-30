import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uafw/snake_controls_guilde.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signup_screen.dart';
import 'package:uafw/widgets/registiry_text_input_login.dart';
import 'fetch_game.dart';

class GameInfo extends StatefulWidget {
  GameInfo({super.key});

  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

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
                fetchGameAssignment(context, widget.uid);
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
            ),
          ],
        ),
      ),
    );
  }
}
