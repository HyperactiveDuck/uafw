// ignore_for_file: avoid_web_libraries_in_flutter, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uafw/widgets/registiry_text_input_login.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:html' as html;
import 'login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
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

void _clearFormFields(TextEditingController controller) {
  controller.clear();
}

bool checkBoxChecked = false;

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void addUserToKullanicilar(User user) async {
    try {
      // Get the current user's UID (Firebase Authentication UID)
      String uid = user.uid;
      // Get the user's name and email from the respective TextEditingController
      String name = _nameController.text;
      String email = _emailController.text;

      // Create a reference to the user's document in the "kullanicilar" collection
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('kullanicilar').doc(uid);

      // Check if the document already exists to avoid overwriting existing data
      DocumentSnapshot userSnapshot = await userRef.get();
      if (!userSnapshot.exists) {
        // If the document doesn't exist, create it with the user's name, email, and the "game_assignment" field
        // Here, we'll assign a default game value "snake" to each user
        await userRef.set({
          'uid': uid,
          'isim': name,
          'eposta': email,
          'oyun': 'atanmadi',
        });
      }
    } catch (e) {
      debugPrint('Error adding user to "kullanicilar" collection: $e');
    }
  }

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
    bool isCheckboxChecked = checkBoxChecked;

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
                controller: _nameController,
                fieldType: FormFieldType.Name,
                formWidth: 250,
              ),
              const SizedBox(
                height: 20,
              ),
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
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          // Register button - Greyed out if checkbox is not checked
          TextButton(
            onPressed: isCheckboxChecked
                ? () async {
                    try {
                      final String email = _getEmail();
                      final String password = _getPassword();
                      final authResult = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (authResult.user != null) {
                        addUserToKullanicilar(authResult.user!);
                      }
                      // Display a success alert
                      _showSuccessAlert(context, "Hesabınız oluşturuldu");

                      // Clear the form fields after successful signup
                      _clearFormFields(_emailController);
                      _clearFormFields(_passwordController);
                    } catch (e) {
                      // Handle errors during signup
                      _showErrorAlert(
                          context, "Hesap oluşturulamadı\n Hata Kodu : $e");
                      _clearFormFields(_emailController);
                      _clearFormFields(_passwordController);
                      _clearFormFields(_nameController);
                    }
                  }
                : null, // Set to null to disable the button when checkbox is not checked
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(200, 30)),
              overlayColor:
                  const MaterialStatePropertyAll(Color.fromRGBO(27, 97, 89, 1)),

              // Set the color to grey when the checkbox is not checked
              backgroundColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey; // Grey out when disabled
                }
                return const Color.fromRGBO(57, 210, 192, 1); // Default color
              }),
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
