import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uafw/allert.dart';
import 'package:uafw/forgot_password.dart';
import 'package:uafw/signup_screen.dart';
import 'widgets/registiry_text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 48, 54),
      body: Column(
        children: [
          const SizedBox(
            height: 250,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  ChoiceChip(
                    avatar: const Icon(Icons.person_rounded),
                    autofocus: true,
                    surfaceTintColor: Colors.teal,
                    label: const Text(
                      'Giriş Yap',
                      style: TextStyle(),
                    ),
                    selectedColor: const Color.fromRGBO(57, 210, 192, 1),
                    pressElevation: 8.0,
                    selected: true,
                    onSelected: (bool value) {
                      setState(
                        () {},
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                      surfaceTintColor: Colors.white,
                      avatar: const Icon(Icons.person_add_rounded),
                      label: const Text('Kayıt Ol'),
                      selected: false,
                      onSelected: (bool value) {
                        setState(
                          () {
                            Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  childCurrent: const LoginPage(),
                                  child: const RegisterPage(),
                                ));
                          },
                        );
                      }),
                ],
              )
            ],
          ),
          Container(
            height: 45,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormValidation(
                fieldType: FormFieldType.Email,
                formWidth: 250,
              ),
              SizedBox(
                height: 20,
              ),
              FormValidation(
                fieldType: FormFieldType.Password,
                formWidth: 250,
              ),
            ],
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
                    childCurrent: const LoginPage(),
                    child: const GameInfo(),
                  ));
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(200, 30)),
              overlayColor:
                  const MaterialStatePropertyAll(Color.fromRGBO(27, 97, 89, 1)),
              backgroundColor: const MaterialStatePropertyAll(
                  Color.fromRGBO(57, 210, 192, 1)),
            ),
            child: const Text(
              'Giriş Yap',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
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
                    childCurrent: const LoginPage(),
                    child: const ResetPass(),
                  ));
            },
            child: const Text(
              'Şifremi Unuttum',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
