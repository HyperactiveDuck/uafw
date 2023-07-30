import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'snake_controls_guilde.dart';
import 'tetris_controls_guilde.dart';
import 'no_game.dart';

// Define an async function to fetch the game assignment
Future<void> fetchGameAssignment(BuildContext context, String uid) async {
  try {
    // Retrieve the game assignment from Firestore
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(uid)
        .get();

    // Get the game assignment value from the document
    String assignedGame = userSnapshot.get('oyun');

    // Call the navigation function based on the assigned game
    navigateToGameScreen(context, assignedGame);
  } catch (e) {
    // Handle any potential errors
    debugPrint('Error fetching game assignment: $e');
  }
}

// Function to navigate users based on the assigned game
void navigateToGameScreen(BuildContext context, String assignedGame) {
  switch (assignedGame) {
    case 'snake':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SnakeController()),
      );
      break;
    case 'tetris':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TetrisController()),
      );
      break;
    case 'atanmadi':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoGame()),
      );
      break;
    default:
      debugPrint('Bir şeyler ters gitti.');
      break;
  }
}
