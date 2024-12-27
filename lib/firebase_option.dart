import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return webOptions;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidOptions;
      case TargetPlatform.iOS:
        return iosOptions;
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

  static const FirebaseOptions webOptions = FirebaseOptions(
      apiKey: "AIzaSyDelJRXAS9ojOV9Ewi1tAALNkOwqtU4mAI",
      authDomain: "ace-broadcast.firebaseapp.com",
      databaseURL: "https://ace-broadcast-default-rtdb.firebaseio.com",
      projectId: "ace-broadcast",
      storageBucket: "ace-broadcast.firebasestorage.app",
      messagingSenderId: "969430829378",
      appId: "1:969430829378:web:25c78f47d890b5710fe0db",
      measurementId: "G-L4ETWCR5DR");

  static const FirebaseOptions androidOptions = FirebaseOptions(
    apiKey: 'AIzaSyCazkybKsgC8T3ehDcdaOSjvUajbhsX7qw',
    appId: "1:969430829378:web:25c78f47d890b5710fe0db",
    messagingSenderId: "969430829378",
    projectId: "ace-broadcast",
    databaseURL: "https://ace-broadcast-default-rtdb.firebaseio.com",
    storageBucket: "ace-broadcast.firebasestorage.app",
  );

  static const FirebaseOptions iosOptions = FirebaseOptions(
    apiKey: 'AIzaSyCazkybKsgC8T3ehDcdaOSjvUajbhsX7qw',
    appId: "1:969430829378:web:25c78f47d890b5710fe0db",
    messagingSenderId: "969430829378",
    projectId: "ace-broadcast",
    databaseURL: "https://ace-broadcast-default-rtdb.firebaseio.com",
    storageBucket: "ace-broadcast.firebasestorage.app",
    iosClientId: '361249630346-xxxxx.apps.googleusercontent.com',
    iosBundleId: 'com.example.postAce',
  );
}
