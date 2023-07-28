// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:uafw/widgets/registiry_text_input_login.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:html' as html;
import 'login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  String _getEmail() {
    // Replace this with the logic to get the email from the form field.
    return "example@example.com";
  }

  String _getPassword() {
    // Replace this with the logic to get the password from the form field.
    return "your_password";
  }

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

void _showSuccessAlert(BuildContext context, String message) {
  Alert(
    style: const AlertStyle(backgroundColor: Color.fromRGBO(57, 210, 192, 1)),
    context: context,
    desc: message,
    buttons: [
      DialogButton(
        color: const Color.fromRGBO(27, 97, 89, 1),
        onPressed: () => Navigator.pop(context),
        width: 120,
        child: const Text(
          "Teşekkürler",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ],
  ).show();
}

void _showErrorAlert(BuildContext context, String errorMessage) {
  Alert(
    style: const AlertStyle(backgroundColor: Color.fromRGBO(57, 210, 192, 1)),
    context: context,
    desc: errorMessage,
    buttons: [
      DialogButton(
        color: const Color.fromRGBO(27, 97, 89, 1),
        onPressed: () => Navigator.pop(context),
        width: 120,
        child: const Text(
          "Tamam",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ],
  ).show();
}

void _clearFormFields() {
  // Replace this with the logic to clear the form fields after successful signup.
}

bool checkBoxChecked = false;

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _getEmail() {
    return _emailController.text;
  }

  String _getPassword() {
    return _passwordController.text;
  }

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
                controller: _emailController,
                fieldType: FormFieldType.Email,
                formWidth: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              FormValidation(
                controller: _passwordController,
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
            onPressed: () async {
              try {
                final String email = _getEmail();
                final String password = _getPassword();
                final authResult =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                // Display a success alert
                _showSuccessAlert(context, "Hesabınız oluşturuldu");

                // Clear the form fields after successful signup
                _clearFormFields();
              } catch (e) {
                // Handle errors during signup
                _showErrorAlert(context, e.toString());
              }
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(200, 30)),
              overlayColor:
                  const MaterialStatePropertyAll(Color.fromRGBO(27, 97, 89, 1)),
              backgroundColor: const MaterialStatePropertyAll(
                  Color.fromRGBO(57, 210, 192, 1)),
            ),
            child: const Text(
              'Kayıt ol',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
