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
    apiKey: 'AIzaSyCWtj57u1fKhilE4F8ydNpO7u3e-ZFVNjw',
    appId: '1:829759480602:web:02e45749308f9ca9a542a3',
    messagingSenderId: '829759480602',
    projectId: 'basilnjoga-notesapp',
    authDomain: 'basilnjoga-notesapp.firebaseapp.com',
    storageBucket: 'basilnjoga-notesapp.appspot.com',
    measurementId: 'G-81ZPP0ZP4D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCR3yV73dxNe45IdEUf7bbBdvjh4wATEyM',
    appId: '1:829759480602:android:2349728fec411c51a542a3',
    messagingSenderId: '829759480602',
    projectId: 'basilnjoga-notesapp',
    storageBucket: 'basilnjoga-notesapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASnBbNkF0Uu3nquKtacxAWaMT6rDEkmyw',
    appId: '1:829759480602:ios:707e6c6d5f19eda6a542a3',
    messagingSenderId: '829759480602',
    projectId: 'basilnjoga-notesapp',
    storageBucket: 'basilnjoga-notesapp.appspot.com',
    iosClientId: '829759480602-opahc7vu2j0nlj0e05t3cv5q2oq5q5pf.apps.googleusercontent.com',
    iosBundleId: 'tech.basilnjoga.mynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASnBbNkF0Uu3nquKtacxAWaMT6rDEkmyw',
    appId: '1:829759480602:ios:9dfaf2bbbca0176fa542a3',
    messagingSenderId: '829759480602',
    projectId: 'basilnjoga-notesapp',
    storageBucket: 'basilnjoga-notesapp.appspot.com',
    iosClientId: '829759480602-6enp59b2bpn2ur36s2qnsrmer993bmog.apps.googleusercontent.com',
    iosBundleId: 'tech.basilnjoga.mynotes.RunnerTests',
  );
}
