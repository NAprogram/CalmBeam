import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

// Firebase configuration - DEMO CONFIGURATION FOR TESTING
// Replace with your own Firebase project credentials for production
class DefaultFirebaseOptions {
  static const FirebaseOptions currentPlatform = FirebaseOptions(
    apiKey: 'AIzaSyAJsLO-wczjCsKO6PTZXpV2TO5jaoM17SI',
    appId: '1:616442388103:web:29ce530e4a1b517fb76222',
    messagingSenderId: '616442388103',
    projectId: 'calmbeam-5333f',
    authDomain: 'calmbeam-5333f.firebaseapp.com',
    databaseURL: 'https://calmbeam-5333f-default-rtdb.firebaseio.com',
    storageBucket: 'calmbeam-5333f.firebasestorage.app',
  );
}
