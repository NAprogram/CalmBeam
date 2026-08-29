# Lamp Monitor App - Development Instructions

This Flutter application monitors IoT lamp sensor data with Firebase integration.

## Project Overview

- **Type**: Flutter Mobile Application
- **Backend**: Firebase (Authentication, Firestore)
- **Features**: Real-time sensor monitoring, user authentication, color-coded alerts

## Setup Checklist

- [x] Project structure created
- [x] Firebase integration configured
- [x] Authentication (Login/Signup) implemented
- [x] Real-time data monitoring UI created
- [x] Color mapping logic implemented
- [ ] Firebase credentials must be added (see firebase_options.dart)
- [ ] Testing and deployment

## Key Files

- `lib/main.dart` - App entry point with auth state management
- `lib/services/firebase_service.dart` - Firebase operations
- `lib/services/color_service.dart` - Temperature/humidity color logic
- `lib/screens/` - UI screens
- `pubspec.yaml` - Dependencies

## Before Running

1. Create Firebase project at console.firebase.google.com
2. Update `lib/firebase_options.dart` with your credentials
3. Run `flutter pub get`
4. Run `flutter run`

## Color Thresholds

- Temperature: Green 20-24°C, Yellow 18-20°C and 24-26°C, Red < 18°C or > 26°C
- Humidity: Green 40-60%, Yellow 35-40% and 60-70%, Red < 35% or > 70%

## Firebase Security Rules

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
      match /lamps/{lamp=**} {
        allow read, write: if request.auth.uid == userId;
      }
    }
  }
}
```
