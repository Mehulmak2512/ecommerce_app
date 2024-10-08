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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAa1fg5XXl5D643O6F659Jc-b4_YqhYeMg',
    appId: '1:76008913295:android:3f95c19c84a8f386e6f3fa',
    messagingSenderId: '76008913295',
    projectId: 'ecommerce-d075e',
    storageBucket: 'ecommerce-d075e.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBppF_DMsj1I2n3oAHukrEPsbfWScPgq1k',
    appId: '1:76008913295:web:7ade1c479a4dd4a6e6f3fa',
    messagingSenderId: '76008913295',
    projectId: 'ecommerce-d075e',
    authDomain: 'ecommerce-d075e.firebaseapp.com',
    storageBucket: 'ecommerce-d075e.appspot.com',
    measurementId: 'G-8YBKEM84KD',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBYws8WMkTOq9ia0g9rXD0sc9f-hD738Nw',
    appId: '1:76008913295:ios:4a9d4118f8867750e6f3fa',
    messagingSenderId: '76008913295',
    projectId: 'ecommerce-d075e',
    storageBucket: 'ecommerce-d075e.appspot.com',
    iosBundleId: 'com.example.ecommerceApp',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBYws8WMkTOq9ia0g9rXD0sc9f-hD738Nw',
    appId: '1:76008913295:ios:4a9d4118f8867750e6f3fa',
    messagingSenderId: '76008913295',
    projectId: 'ecommerce-d075e',
    storageBucket: 'ecommerce-d075e.appspot.com',
    iosBundleId: 'com.example.ecommerceApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBppF_DMsj1I2n3oAHukrEPsbfWScPgq1k',
    appId: '1:76008913295:web:b267019b08153fc0e6f3fa',
    messagingSenderId: '76008913295',
    projectId: 'ecommerce-d075e',
    authDomain: 'ecommerce-d075e.firebaseapp.com',
    storageBucket: 'ecommerce-d075e.appspot.com',
    measurementId: 'G-CX4RLM8ESP',
  );

}