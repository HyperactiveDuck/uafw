import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/fetch_game.dart';

class GameInfo extends StatefulWidget {
  GameInfo({super.key});

  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  State<GameInfo> createState() => _GameInfoState();
}

class _GameInfoState extends State<GameInfo> {
  Future<void> registerLoginTime() async {
    // Save login date and time to Firestore
    DateTime loginTime = DateTime.now();
    await FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(widget.uid)
        .set({'sonGiris': loginTime}, SetOptions(merge: true));
  }

  Future<void> registerFirstLoginTime() async {
    // Check if the user document already exists
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(widget.uid)
        .get();

    // If the user document exists and "ilkGiris" field is not set, then set it
    if (userDoc.exists &&
        (userDoc.data() as Map<String, dynamic>)['ilkGiris'] == null) {
      DateTime firstLoginTime = DateTime.now();
      await FirebaseFirestore.instance
          .collection('kullanicilar')
          .doc(widget.uid)
          .set({'ilkGiris': firstLoginTime}, SetOptions(merge: true));
    }
  }

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
              onPressed: () async {
                await fetchGameAssignment(context, widget.uid);
                await registerLoginTime();
                await registerFirstLoginTime();
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
