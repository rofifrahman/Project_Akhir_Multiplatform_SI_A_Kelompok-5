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
    apiKey: 'AIzaSyAJFsjm5h-Xmcu6C6ebIf79W_j8j-3xFtQ',
    appId: '1:1036121620009:web:7474b681889042d145a638',
    messagingSenderId: '1036121620009',
    projectId: 'flutter-8e35b',
    authDomain: 'flutter-8e35b.firebaseapp.com',
    databaseURL: 'https://flutter-8e35b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-8e35b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0Eg73JS8VbkBwonfMMmbRa04RCaIaTsA',
    appId: '1:1036121620009:android:f144232e9b173d1a45a638',
    messagingSenderId: '1036121620009',
    projectId: 'flutter-8e35b',
    databaseURL: 'https://flutter-8e35b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-8e35b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqU_sEBGOid_0ct0tSpxiA_G4ZlZUmnQw',
    appId: '1:1036121620009:ios:4a14f1fe8118534745a638',
    messagingSenderId: '1036121620009',
    projectId: 'flutter-8e35b',
    databaseURL: 'https://flutter-8e35b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-8e35b.firebasestorage.app',
    androidClientId: '1036121620009-gagkqr2qjj1h74j3q91nim4302tom56b.apps.googleusercontent.com',
    iosClientId: '1036121620009-7e1srj09umq2dl7mvv2gjp12esajifu9.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectAkhirMultiplatform',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqU_sEBGOid_0ct0tSpxiA_G4ZlZUmnQw',
    appId: '1:1036121620009:ios:4a14f1fe8118534745a638',
    messagingSenderId: '1036121620009',
    projectId: 'flutter-8e35b',
    databaseURL: 'https://flutter-8e35b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-8e35b.firebasestorage.app',
    androidClientId: '1036121620009-gagkqr2qjj1h74j3q91nim4302tom56b.apps.googleusercontent.com',
    iosClientId: '1036121620009-7e1srj09umq2dl7mvv2gjp12esajifu9.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectAkhirMultiplatform',
  );

}