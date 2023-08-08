import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 40, 48, 54),
        body: Center(
          child: Container(
            height: 500,
            width: 900,
            color: const Color.fromARGB(255, 69, 82, 92),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Şifrenizi unuttuysanız lütfen site yöneicisi ile irtibata geçin',
                  style: TextStyle(
                    color: Colors.white70,
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
                        childCurrent: const ResetPass(),
                        child: const LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Geri Dön',
                    style: TextStyle(
                        color: Color.fromARGB(255, 1, 199, 179), fontSize: 40),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
