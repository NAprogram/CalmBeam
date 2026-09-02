import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart'; // Added RTDB package
import 'package:lamp_app/models/lamp_data.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseDatabase _rtdb =
      FirebaseDatabase.instance; // Added RTDB instance

  // Public getter for auth state changes
  Stream<User?> getAuthStateChanges() {
    return _auth.authStateChanges();
  }

  // Authentication Methods
  Future<UserCredential?> signUp(
      String email, String password, String displayName) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(displayName);

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'uid': userCredential.user?.uid,
        'email': email,
        'displayName': displayName,
        'createdAt': DateTime.now().toIso8601String(),
      });

      return userCredential;
    } catch (e) {
      print('Sign up error: $e');
      return null;
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print('Sign in error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Sign out error: $e');
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // --- UPDATED: Lamp Data Methods reading from Realtime Database ---
  Stream<List<LampData>> getLampDataStream(String userId) {
    // Listen directly to the 'lampData' node your ESP32 is writing to
    return _rtdb.ref('lampData').onValue.map((event) {
      if (event.snapshot.value == null) return [];

      // Extract the data payload from the ESP32
      final data = event.snapshot.value as Map<dynamic, dynamic>;

      // Map it to your existing LampData model
      return [
        LampData(
          id: 'calmbeam_esp32',
          lampName: 'CalmBeam Desk Lamp',
          temperature: (data['temperature'] ?? 0.0).toDouble(),
          humidity: (data['humidity'] ?? 0.0).toDouble(),
          timestamp: DateTime.now(),
          status: 'online',
        )
      ];
    });
  }

  // Note: Add/Update/Delete methods below are kept for your UI,
  // but the ESP32 is now the single source of truth for the sensor data.
  Future<void> addLampData(String userId, LampData lampData) async {
    // Left empty: ESP32 handles creating data
  }

  Future<void> updateLampData(String userId, LampData lampData) async {
    // Left empty: ESP32 handles updating data
  }

  Future<void> deleteLampData(String userId, String lampId) async {
    try {
      await _rtdb.ref('lampData').remove();
    } catch (e) {
      print('Delete lamp data error: $e');
    }
  }
}
// [Auto-Sync] Diagnostic check passed at 2026-09-02 10:12:15
