import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UserScore {
  final int score;
  final DateTime date;
  final bool isBestScore;

  UserScore({
    required this.score,
    required this.date,
    required this.isBestScore,
  });

  // Convert UserScore object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'score': score,
      'date': Timestamp.fromDate(
          date), // Convert DateTime to Timestamp for Firestore
      'isBestScore': isBestScore,
    };
  }
}

Future<void> saveUserScore(String userId, UserScore score) async {
  try {
    final firebaseApp = await Firebase.initializeApp();
    final firestore = FirebaseFirestore.instanceFor(app: firebaseApp);
    final userScoresRef = firestore.collection('user_scores').doc(userId);

    // Get the user's existing best score (if available)
    final userScoresSnapshot = await userScoresRef.get();
    final bestScore = userScoresSnapshot.data()?['best_score'] ?? 0;

    // Check if the new score is the best score
    final isBestScore = score.score > bestScore;

    // Save the score to Firestore
    await userScoresRef.collection('scores').add(score.toMap());

    // Update the user's best score if it's the best score so far
    if (isBestScore) {
      await userScoresRef.set({
        'best_score': score.score,
        'best_score_date': Timestamp.fromDate(score.date),
      }, SetOptions(merge: true));
    }
  } catch (e) {
    // Handle any errors that occur while saving the score
    print('Error saving user score: $e');
  }
}
