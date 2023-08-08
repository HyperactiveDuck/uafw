import 'package:flutter/material.dart';
import 'package:uafw/snakegame.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GamePageSnake extends StatefulWidget {
  const GamePageSnake({super.key});

  @override
  State<GamePageSnake> createState() => _GamePageSnakeState();
}

class _GamePageSnakeState extends State<GamePageSnake> {
  String gameName = 'Yılan Oyunu';

  Future<void> saveScoreToFirestore(int score) async {
    try {
      // Get the current user's UID
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        debugPrint('User is not logged in.');
        return;
      }
      final String userUID = user.uid;

      // Get a reference to the user's document in the "kullanicilar" collection
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('kullanicilar');
      final DocumentReference userDocument = usersCollection.doc(userUID);

      // Get the current date in Firestore Timestamp format
      final Timestamp currentDate = Timestamp.now();

      // Create a map with the date as the key and the score as the value
      final Map<String, dynamic> scoreData = {
        currentDate.toDate().toString(): score,
      };

      // Update the user's document with the new score
      await userDocument.update(scoreData);
    } catch (e) {
      debugPrint('Error saving score to Firestore: $e');
      // Handle the error if needed
    }
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
