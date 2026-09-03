import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lamp_app/firebase_options.dart';
import 'package:lamp_app/screens/login_screen.dart';
import 'package:lamp_app/screens/home_screen.dart';
import 'package:lamp_app/screens/demo_home_screen.dart';
import 'package:lamp_app/services/firebase_service.dart';

// Set to true for demo mode (no Firebase required)
const bool DEMO_MODE = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!DEMO_MODE) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lamp Monitor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF667EEA)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: DEMO_MODE ? DemoHomeScreen() : _AuthGate(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/demo': (context) => DemoHomeScreen(),
      },
    );
  }
}

class _AuthGate extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    // This should never be reached when DEMO_MODE is true
    return StreamBuilder(
      stream: _firebaseService.getAuthStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
// [Auto-Sync] Diagnostic check passed at 2026-09-03 08:37:46
