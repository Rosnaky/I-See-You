// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDW_O794d2HHWZ5OVwRynbO5DXbNh6nFtY',
    appId: '1:471457794969:web:dcf2d171ba56b2f3326108',
    messagingSenderId: '471457794969',
    projectId: 'iseeyouinyourhome',
    authDomain: 'iseeyouinyourhome.firebaseapp.com',
    storageBucket: 'iseeyouinyourhome.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaGIEkI41-hG_g59cUD4Qoa31aIAORpRs',
    appId: '1:471457794969:android:4a2f752c09751388326108',
    messagingSenderId: '471457794969',
    projectId: 'iseeyouinyourhome',
    storageBucket: 'iseeyouinyourhome.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCONuQo9pD3ByXfd8aGEA4AaAinPOGqWC8',
    appId: '1:471457794969:ios:9568f913b6313b71326108',
    messagingSenderId: '471457794969',
    projectId: 'iseeyouinyourhome',
    storageBucket: 'iseeyouinyourhome.appspot.com',
    iosBundleId: 'com.example.icuInYourHome',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCONuQo9pD3ByXfd8aGEA4AaAinPOGqWC8',
    appId: '1:471457794969:ios:9568f913b6313b71326108',
    messagingSenderId: '471457794969',
    projectId: 'iseeyouinyourhome',
    storageBucket: 'iseeyouinyourhome.appspot.com',
    iosBundleId: 'com.example.icuInYourHome',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDW_O794d2HHWZ5OVwRynbO5DXbNh6nFtY',
    appId: '1:471457794969:web:e85788e1a867ec80326108',
    messagingSenderId: '471457794969',
    projectId: 'iseeyouinyourhome',
    authDomain: 'iseeyouinyourhome.firebaseapp.com',
    storageBucket: 'iseeyouinyourhome.appspot.com',
  );
}
