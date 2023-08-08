import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class NoGame extends StatefulWidget {
  NoGame({super.key});

  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  State<NoGame> createState() => _NoGameState();
}

class _NoGameState extends State<NoGame> {
  Future<void> _signOutUser() {
    return FirebaseAuth.instance.signOut();
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
              'Henüz hesabınıza bir oyun atanmadı.\nLütfen daha sonra tekrar deneyiniz.',
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
                _signOutUser().then((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }).catchError((error) {
                  debugPrint('Hata: $error');
                });
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
