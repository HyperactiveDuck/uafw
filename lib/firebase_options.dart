// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC4ZzKacJmSjCLByaTPIegs1LiprlHKdJ8',
    appId: '1:471832145333:web:b6455a8251d9362ff63dfc',
    messagingSenderId: '471832145333',
    projectId: 'umut-ocak',
    authDomain: 'umut-ocak.firebaseapp.com',
    databaseURL:
        'https://umut-ocak-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'umut-ocak.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnPqyNxsru2zqm8nDQv6EqsFPofpKgxdk',
    appId: '1:471832145333:android:3045ec9b225aa836f63dfc',
    messagingSenderId: '471832145333',
    projectId: 'umut-ocak',
    databaseURL:
        'https://umut-ocak-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'umut-ocak.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjl916QsiPEI4aWO_hkahJjvhahZ56aGo',
    appId: '1:471832145333:ios:f679f49072841377f63dfc',
    messagingSenderId: '471832145333',
    projectId: 'umut-ocak',
    databaseURL:
        'https://umut-ocak-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'umut-ocak.appspot.com',
    iosClientId:
        '471832145333-3qu4v0o9rd87bu60o9lvn8s8t9afd1t8.apps.googleusercontent.com',
    iosBundleId: 'com.example.uafw',
  );
}
