import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Umut Ocak Psikiloji Testi',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
