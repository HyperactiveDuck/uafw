import 'package:flutter/material.dart';
import 'package:uafw/snakegame.dart';
import 'package:page_transition/page_transition.dart';

class SnakeController extends StatefulWidget {
  const SnakeController({super.key});

  @override
  State<SnakeController> createState() => _SnakeControllerState();
}

class _SnakeControllerState extends State<SnakeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 40, 48, 54),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Title(
                  color: Colors.black,
                  child: const Text(
                    'Yılan Oyunu',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
              const Text(
                'Yılanı yön tuşlarıyla kontrol edebilirsiniz \nYılan duvarlardan geçemez , duvaralara değdiniz an oyun biter. \nYılan kendi kuyruğuna değemez , değdiğ an oyun biter.\nYılan yalnızca oyunun başında gittiği yönün tersine dönebilir , ilk yemi yedikten sonra birdaha 180° dönüş yapamaz ',
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
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        childCurrent: const SnakeController(),
                        child: const MyApp(),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 21, 26, 29),
                  ),
                  height: 60,
                  width: 100,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Başla',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
