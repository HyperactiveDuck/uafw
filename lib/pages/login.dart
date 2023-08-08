// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uafw/pages/allert.dart';
import 'package:uafw/pages/daily_limit.dart';
import 'package:uafw/pages/forgot_password.dart';
import 'package:uafw/pages/signup_screen.dart';
import '../widgets/registiry_text_input_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isWithin16Hours(DateTime lastLogin) {
    DateTime now = DateTime.now();
    Duration timeDifference = now.difference(lastLogin);
    return timeDifference.inHours < 16;
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

  void _showErrorAlert(String errorMessage) {
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
          TextButton(
            onPressed: () async {
              try {
                final String email = _getEmail();
                final String password = _getPassword();
                final authResult = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);

                if (authResult.user != null) {
                  String userId = authResult.user!.uid;

                  // Get the user document from Firestore
                  DocumentSnapshot userSnapshot = await FirebaseFirestore
                      .instance
                      .collection('kullanicilar')
                      .doc(userId)
                      .get();

                  // Check if the document exists in Firestore
                  if (userSnapshot.exists) {
                    // Check if the 'lastLogin' field exists in the document
                    Map<String, dynamic>? userData =
                        userSnapshot.data() as Map<String, dynamic>?;
                    if (userData != null && userData.containsKey('sonGiris')) {
                      DateTime lastLogin = userData['sonGiris'].toDate();
                      DateTime now = DateTime.now();

                      // Calculate the time difference between now and the last login
                      Duration timeDifference = now.difference(lastLogin);
                      bool canLogin = timeDifference.inHours >= 16;

                      if (canLogin) {
                        // Navigate to the Allert page after successful login
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameInfo(),
                          ),
                        );
                      } else {
                        // Handle the case when the user needs to wait before logging in again
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TimeOut(),
                          ),
                        );
                      }
                    } else {
                      // If the 'lastLogin' field does not exist in the document, the user is logging in for the first time.
                      // Proceed with normal login and navigate to the Allert page.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameInfo(),
                        ),
                      );
                    }
                  } else {
                    // If the document does not exist in Firestore, the user is logging in for the first time.
                    // Proceed with normal login and navigate to the Allert page.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameInfo(),
                      ),
                    );
                  }
                } else {
                  // Handle the case when authResult.user is null (shouldn't happen in this case)
                  _showErrorAlert("Login failed. Please try again.");
                }
              } catch (e) {
                debugPrint(e.toString());
                // Handle errors during login
                switch (e.toString()) {
                  case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
                    _showErrorAlert(
                        "Böyle bir kullanıcı bulunmamaktadır. Lütfen bilgilerinizi kontrol edip tekrar deneyin.");
                    break;
                  case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
                    _showErrorAlert(
                        "Giriş Başarısız. Lütfen Bilgilerinizi kontrol edip tekrar deneyin.");
                    break;
                  case '[firebase_auth/invalid-email] The email address is badly formatted.':
                    _showErrorAlert(
                        "Giriş Başarısız. Lütfen Bilgilerinizi kontrol edip tekrar deneyin.");
                    break;
                  default:
                    _showErrorAlert("Bir şeyler ters gitti. Tekrar deneyin.");
                    break;
                }
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
