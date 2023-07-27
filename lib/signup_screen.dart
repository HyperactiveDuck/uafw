// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:uafw/widgets/registiry_text_input.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:html' as html;
import 'login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

bool checkBoxChecked = false;

class _RegisterPageState extends State<RegisterPage> {
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
                    label: const Text(
                      'Giriş Yap',
                      style: TextStyle(),
                    ),
                    pressElevation: 8.0,
                    selected: false,
                    onSelected: (bool value) {
                      setState(
                        () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                childCurrent: const RegisterPage(),
                                child: const LoginPage(),
                              ));
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                      selectedColor: const Color.fromRGBO(57, 210, 192, 1),
                      surfaceTintColor: Colors.teal,
                      avatar: const Icon(Icons.person_add_rounded),
                      label: const Text('Kayıt Ol'),
                      selected: true,
                      onSelected: (bool value) {
                        setState(
                          () {},
                        );
                      }),
                ],
              )
            ],
          ),
          Container(
            height: 45,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormValidation(
                fieldType: FormFieldType.Name,
                formWidth: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              FormValidation(
                fieldType: FormFieldType.Email,
                formWidth: 250,
              ),
              const SizedBox(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: checkBoxChecked,
                onChanged: (bool? value) {
                  setState(() {
                    checkBoxChecked = value!;
                  });
                },
                side: const BorderSide(
                  color: Color.fromRGBO(57, 210, 192, 1),
                  width: 1,
                ),
              ),
              InkWell(
                onTap: () {
                  html.window.open('docs/gnlktlmfrm.pdf', 'new tab');
                },
                child: const Text(
                  'Gönüllü katılım formunu okudum , kabul ediyorum.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Alert(
                  style: AlertStyle(
                      backgroundColor: Color.fromRGBO(57, 210, 192, 1)),
                  context: context,
                  desc: "Hesabınız oluşturuldu",
                  buttons: [
                    DialogButton(
                      color: Color.fromRGBO(27, 97, 89, 1),
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                      child: const Text(
                        "Teşekkürler",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ).show();
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(200, 30)),
                overlayColor: const MaterialStatePropertyAll(
                  Color.fromRGBO(27, 97, 89, 1),
                ),
                backgroundColor: const MaterialStatePropertyAll(
                  Color.fromRGBO(57, 210, 192, 1),
                ),
              ),
              child: const Text(
                'Kayıt ol',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
