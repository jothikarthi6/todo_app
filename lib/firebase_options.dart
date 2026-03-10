
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;        // ← iOS Simulator uses this
      default:
        return ios;
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDiIfwrWNeqTcmeR2mXl5EECgPCh3QU-cU',
    appId: '1:831424500635:ios:05e459504940d43734873e',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'todoapp-d308a',
    databaseURL: 'YOUR_DATABASE_URL',
    storageBucket: 'todoapp-d308a.firebasestorage.app',
  );

static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'AIzaSyC6NllGsUpMtoifP6Biah7N2rIxAP8VkAM',
  appId: '1:831424500635:ios:05e459504940d43734873e',
  messagingSenderId: '831424500635',
  projectId: 'todoapp-d308a',
  databaseURL: 'https://todoapp-d308a-default-rtdb.firebaseio.com',
  storageBucket: 'todoapp-d308a.firebasestorage.app',
  iosClientId: 'YOUR_IOS_CLIENT_ID',
  iosBundleId: 'com.jothi.todoApp',
);
}
