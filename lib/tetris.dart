import 'package:flutter/material.dart';
import 'package:uafw/tetris_game/tetris.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(brightness: Brightness.dark).copyWith(
          scaffoldBackgroundColor: Colors.black,
          dividerColor: const Color(0xFF2F2F2F),
          dividerTheme: const DividerThemeData(thickness: 10),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Tetris(),
      );
}
