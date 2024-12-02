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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZdqPSDhN3LIRMHvVe6rLjlfqr3zU68vE',
    appId: '1:255025957893:android:6884f5701bcb3ea147a06c',
    messagingSenderId: '255025957893',
    projectId: 'agenda-6f48f',
    storageBucket: 'agenda-6f48f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtZjGaKWdXOTeytmHhHqrCWXyohFyGkOI',
    appId: '1:255025957893:ios:c61977a3d5103f8347a06c',
    messagingSenderId: '255025957893',
    projectId: 'agenda-6f48f',
    storageBucket: 'agenda-6f48f.firebasestorage.app',
    iosBundleId: 'com.example.agenda',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAIn0VC3Ybi1SEAn_-yaDg8hptgcRr9H6o',
    appId: '1:255025957893:web:5a165932afaf6c3147a06c',
    messagingSenderId: '255025957893',
    projectId: 'agenda-6f48f',
    authDomain: 'agenda-6f48f.firebaseapp.com',
    storageBucket: 'agenda-6f48f.firebasestorage.app',
    measurementId: 'G-Y2TECBJDVF',
  );
}
