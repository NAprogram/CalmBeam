# Lamp Monitor App

A Flutter application for monitoring IoT lamp sensor data with real-time temperature and humidity tracking, Firebase authentication, and cloud database integration.

## Features

- **User Authentication**: Sign up and login with Firebase Authentication
- **Real-time Sensor Monitoring**: Track temperature and humidity data from multiple lamps
- **Color-coded Indicators**: 
  - Green (Optimal)
  - Yellow (Normal)
  - Red (Bad/Alert)
- **Firebase Integration**: Cloud Firestore for data storage and Firebase Auth for user management
- **Beautiful UI**: Material Design 3 with gradient backgrounds and smooth animations
- **Add/Delete Lamps**: Manage multiple lamp connections

## Prerequisites

- Flutter SDK (3.0.0 or higher)
- Firebase Project
- Android Studio or Xcode
- Dart

## Setup Instructions

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project
3. Enable Firebase Authentication (Email/Password)
4. Create a Firestore Database
5. Get your Firebase configuration

### 2. Update Firebase Configuration

Update `lib/firebase_options.dart` with your Firebase credentials:

```dart
class DefaultFirebaseOptions {
  static const FirebaseOptions currentPlatform = FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    appId: 'YOUR_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    authDomain: 'YOUR_AUTH_DOMAIN',
    databaseURL: 'YOUR_DATABASE_URL',
    storageBucket: 'YOUR_STORAGE_BUCKET',
  );
}
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

```bash
flutter run
```

## Project Structure

```
lamp_app/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── firebase_options.dart     # Firebase configuration
│   ├── models/
│   │   ├── lamp_data.dart       # Lamp data model
│   │   └── user_model.dart      # User model
│   ├── services/
│   │   ├── firebase_service.dart # Firebase operations
│   │   └── color_service.dart    # Color mapping logic
│   ├── screens/
│   │   ├── login_screen.dart    # Login UI
│   │   ├── signup_screen.dart   # Signup UI
│   │   └── home_screen.dart     # Main dashboard
│   └── widgets/
│       └── sensor_card.dart      # Sensor display card
├── android/                      # Android configuration
├── ios/                          # iOS configuration
└── pubspec.yaml                  # Dependencies
```

## Temperature Color Mapping

- **Red**: < 18°C or > 26°C (Bad)
- **Yellow**: 18-20°C or 24-26°C (Normal)
- **Green**: 20-24°C (Perfect)

## Humidity Color Mapping

- **Red**: < 35% or > 70% (Bad)
- **Yellow**: 35-40% or 60-70% (Normal)
- **Green**: 40-60% (Perfect)

## Firebase Database Structure

```
users/
├── {uid}/
│   ├── email: string
│   ├── displayName: string
│   ├── createdAt: timestamp
│   └── lamps/
│       └── {lampId}/
│           ├── id: string
│           ├── lampName: string
│           ├── temperature: number
│           ├── humidity: number
│           ├── timestamp: string
│           └── status: string
```

## Security Rules

Add these Firestore security rules:

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

## Features to Consider Adding

- Real-time notifications for alerts
- Data history and charts
- Multiple user support (sharing lamps)
- Export data as CSV/PDF
- Dark mode support
- Push notifications for critical values
- API integration with actual IoT devices

## Troubleshooting

### Firebase Connection Issues
- Verify API key is correct
- Check Firestore rules
- Ensure internet connection

### Build Issues
- Run `flutter clean`
- Run `flutter pub get`
- Check SDK versions

## License

This project is open source and available for educational purposes.

## Support

For issues or questions, please refer to:
- [Flutter Documentation](https://docs.flutter.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
