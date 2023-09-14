import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universal_html/html.dart' as html;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnakeGame(),
    );
  }
}

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  SnakeGameState createState() => SnakeGameState();
}

class SnakeGameState extends State<SnakeGame> {
  static int puan = 0;

  final int squaresPerRow = 40;
  final int squaresPerCol = 20;
  final fontStyle = const TextStyle(color: Colors.white, fontSize: 20);
  final randomGen = Random();

  var snake = [
    [0, 1],
    [0, 0]
  ];
  var food = [0, 2];
  var direction = 'up';
  var isPlaying = false;
  var remainingTime = 900; // 15 minutes in seconds

  Timer? timer; // Timer object to handle countdown

  // Add a flag to check if the game has ended
  var gameEnded = false;

  void startGame() {
    const duration = Duration(milliseconds: 100);

    snake = [
      // Snake head
      [(squaresPerRow / 2).floor(), (squaresPerCol / 2).floor()]
    ];

    snake.add([snake.first[0], snake.first[1] + 1]); // Snake body

    createFood();

    isPlaying = true;

    // Cancel the previous timer if it exists
    timer?.cancel();

    // Start the countdown timer
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        remainingTime--;
      });

      if (remainingTime <= 0) {
        t.cancel();
        endGame();
      }
    });

    Timer.periodic(duration, (Timer timer) {
      moveSnake();
      if (checkGameOver()) {
        timer.cancel();
        saveScoreToFirestore((snake.length - 2) * 100);
        resetGame();
      }
    });
  }

  void resetGame() {
    // Reset game-related variables and UI
    setState(() {
      snake = [
        // Snake head
        [(squaresPerRow / 2).floor(), (squaresPerCol / 2).floor()]
      ];

      snake.add([snake.first[0], snake.first[1] + 1]); // Snake body

      createFood();

      direction = 'up';
      isPlaying = false;
      // Reset the time
      gameEnded = false; // Reset the game-ended flag
      SnakeGameState.puan = 0; // Reset the score
    });
  }

  void moveSnake() {
    setState(() {
      switch (direction) {
        case 'up':
          snake.insert(0, [snake.first[0], snake.first[1] - 1]);
          break;

        case 'down':
          snake.insert(0, [snake.first[0], snake.first[1] + 1]);
          break;

        case 'left':
          snake.insert(0, [snake.first[0] - 1, snake.first[1]]);
          break;

        case 'right':
          snake.insert(0, [snake.first[0] + 1, snake.first[1]]);
          break;
      }

      if (snake.first[0] != food[0] || snake.first[1] != food[1]) {
        snake.removeLast();
      } else {
        createFood();
      }
      SnakeGameState.puan = (snake.length - 2) * 100;
    });
  }

  void createFood() {
    food = [randomGen.nextInt(squaresPerRow), randomGen.nextInt(squaresPerCol)];
  }

  bool checkGameOver() {
    if (!isPlaying ||
        snake.first[1] < 0 ||
        snake.first[1] >= squaresPerCol ||
        snake.first[0] < 0 ||
        snake.first[0] > squaresPerRow) {
      return true;
    }

    for (var i = 1; i < snake.length; ++i) {
      if (snake[i][0] == snake.first[0] && snake[i][1] == snake.first[1]) {
        return true;
      }
    }

    return false;
  }

  void endGame() {
    isPlaying = false;
    gameEnded = true; // Set the flag to true when the game ends

    showDialog(
      context: context,
      barrierDismissible:
          false, // Disable tapping outside the alert to close it
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oyun Bitti'),
          content: const Text(
            'Süreniz Doldu!',
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Skoru Yükle ve Çıkış Yap'),
              onPressed: () async {
                gameEnded = false;
                html.window.location.reload();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> saveScoreToFirestore(int score) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        debugPrint('User is not logged in.');
        return;
      }
      final String userUID = user.uid;

      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('kullanicilar');
      final DocumentReference userDocument = usersCollection.doc(userUID);

      // Get the current date in Firestore Timestamp format
      final Timestamp currentDate = Timestamp.now();

      // Fetch the existing "Tarih ve Skor" map from Firestore
      final DocumentSnapshot userSnapshot = await userDocument.get();

      // Cast the retrieved data to a Map<String, dynamic> type
      final Map<String, dynamic>? existingData =
          userSnapshot.data() as Map<String, dynamic>?;

      // Calculate the day difference between currentDate and ilkGiris
      final Timestamp ilkGirisTimestamp = existingData?['ilkGiris'];
      final int dayDifference =
          currentDate.toDate().difference(ilkGirisTimestamp.toDate()).inDays;

      // Create an empty map if there's no existing data
      final Map<String, dynamic> existingScores =
          existingData?['Tarih ve Skor'] ?? {};

      // Create a new map for the day's scores if it doesn't exist
      final Map<String, dynamic> dayScores =
          existingScores['Gün $dayDifference'] ?? {};

      // Calculate the total score for the day's scores map
      int totalScore = dayScores['Total Score'] ?? 0;
      totalScore += score;

      // Check if the current score is higher than the previously recorded "Highest Score" for the day and update it accordingly
      if (score > (dayScores['Highest Score'] ?? 0)) {
        dayScores['Highest Score'] = score;
      }

      // Add the new score to the day's scores map with the current timestamp
      dayScores[currentDate.toDate().toString()] = score;

      // Update the day's total score with the new total score
      dayScores['Total Score'] = totalScore;

      // Update the user's document with the updated day's scores map
      existingScores['Gün $dayDifference'] = dayScores;

      await userDocument.update({
        "Tarih ve Skor": existingScores,
      });
    } catch (e) {
      debugPrint('Error saving score to Firestore: $e');
      // Handle the error if needed
    }
  }

  void handleVerticalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dy > 0 && direction != 'up') {
      direction = 'down';
    } else if (details.delta.dy < 0 && direction != 'down') {
      direction = 'up';
    }
  }

  void handleHorizontalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0 && direction != 'left') {
      direction = 'right';
    } else if (details.delta.dx < 0 && direction != 'right') {
      direction = 'left';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: handleVerticalDragUpdate,
              onHorizontalDragUpdate: handleHorizontalDragUpdate,
              child: AspectRatio(
                aspectRatio: squaresPerRow / (squaresPerCol + 5),
                child: Focus(
                  autofocus: true,
                  onKey: (node, event) {
                    if (event is RawKeyDownEvent) {
                      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                        setState(() {
                          direction = 'up';
                        });
                        return KeyEventResult.handled;
                      } else if (event.logicalKey ==
                          LogicalKeyboardKey.arrowDown) {
                        setState(() {
                          direction = 'down';
                        });
                        return KeyEventResult.handled;
                      } else if (event.logicalKey ==
                          LogicalKeyboardKey.arrowLeft) {
                        setState(() {
                          direction = 'left';
                        });
                        return KeyEventResult.handled;
                      } else if (event.logicalKey ==
                          LogicalKeyboardKey.arrowRight) {
                        setState(() {
                          direction = 'right';
                        });
                        return KeyEventResult.handled;
                      }
                    }
                    return KeyEventResult.ignored;
                  },
                  child: Center(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: squaresPerRow,
                      ),
                      itemCount: squaresPerRow * squaresPerCol,
                      itemBuilder: (BuildContext context, int index) {
                        Color? color;
                        var x = index % squaresPerRow;
                        var y = (index / squaresPerRow).floor();

                        bool isSnakeBody = false;
                        for (var pos in snake) {
                          if (pos[0] == x && pos[1] == y) {
                            isSnakeBody = true;
                            break;
                          }
                        }

                        if (snake.first[0] == x && snake.first[1] == y) {
                          color = Colors.green;
                        } else if (isSnakeBody) {
                          color = Colors.green[200];
                        } else if (food[0] == x && food[1] == y) {
                          color = Colors.red;
                        } else {
                          color = Colors.grey[800];
                        }

                        return Container(
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Kalan Süre: ${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        gameEnded
                            ? Colors.grey
                            : (isPlaying ? Colors.red : Colors.blue),
                      ),
                    ),
                    onPressed:
                        gameEnded // Disable the button if the game has ended
                            ? null
                            : () {
                                if (isPlaying) {
                                  isPlaying = false;
                                  timer?.cancel();
                                } else {
                                  startGame();
                                }
                              },
                    child: Text(
                      isPlaying ? 'Bitir' : 'Başlat',
                      style: fontStyle,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Skor: ${snake.length - 2}',
                    style: fontStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
