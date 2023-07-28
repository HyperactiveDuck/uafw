import 'package:flutter/material.dart';
import 'game_page_snake.dart';
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
              Container(
                height: 300,
                width: 1000,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Yılanı yön tuşlarıyla kontrol edebilirsiniz \nYılan duvarlardan geçemez , duvaralara değdiniz an oyun biter. \nYılan kendi kuyruğuna değemez , değdiğ an oyun biter.\nYılan yalnızca oyunun başında gittiği yönün tersine dönebilir , ilk yemi yedikten sonra birdaha 180° dönüş yapamaz ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              childCurrent: const SnakeController(),
                              child: const GamePageSnake(),
                            ));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.teal),
                      ),
                      child: const Text(
                        'Başla',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
