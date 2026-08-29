# SETUP GUIDE.md

## Flutter Lamp Monitor App - Complete Setup Guide

### Overview
This is a fully functional Flutter app that monitors IoT lamp sensor data with Firebase integration. It includes user authentication, real-time data monitoring, and color-coded temperature/humidity indicators.

### ⚠️ IMPORTANT: Firebase Setup Required

**This app will NOT work without Firebase configuration. Follow these steps:**

### Step 1: Create Firebase Project

1. Visit [Firebase Console](https://console.firebase.google.com)
2. Click "Create a project"
3. Name it (e.g., "Lamp Monitor")
4. Enable Google Analytics (optional)
5. Click "Create"

### Step 2: Enable Authentication

1. In Firebase Console, go to **Authentication**
2. Click **Get Started**
3. Select **Email/Password**
4. Click **Enable**
5. Save

### Step 3: Create Firestore Database

1. Go to **Firestore Database**
2. Click **Create database**
3. Select **Start in test mode**
4. Choose location (closest to you)
5. Click **Create**

### Step 4: Get Firebase Credentials

1. Go to **Project Settings** (gear icon)
2. Under "Your apps", click **Add app** → **Flutter**
3. Register the app
4. Download the configuration files:
   - For Android: `google-services.json`
   - For iOS: `GoogleService-Info.plist`

### Step 5: Add Configuration Files

**For Android:**
1. Copy `google-services.json` to `android/app/`
2. That's it! The app will auto-configure

**For iOS:**
1. Open `ios/Runner.xcworkspace` in Xcode
2. Drag `GoogleService-Info.plist` to Runner folder
3. Ensure "Copy items if needed" is checked

### Step 6: Update Firebase Options (IMPORTANT)

Edit `lib/firebase_options.dart`:

```dart
class DefaultFirebaseOptions {
  static const FirebaseOptions currentPlatform = FirebaseOptions(
    apiKey: 'AIzaSyDxxxx...', // Get from google-services.json
    appId: '1:123456789:android:xxxxxxxx', 
    messagingSenderId: '123456789',
    projectId: 'lamp-monitor-xxxxx',
    authDomain: 'lamp-monitor-xxxxx.firebaseapp.com',
    databaseURL: 'https://lamp-monitor-xxxxx.firebaseio.com',
    storageBucket: 'lamp-monitor-xxxxx.appspot.com',
  );
}
```

Get these values from:
- **Project Settings** → **Accounts & Access** tab
- Or from your `google-services.json` file

### Step 7: Set Firestore Security Rules

1. Go to Firestore Database → **Rules**
2. Replace with:

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

3. Click **Publish**

### Step 8: Run the App

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Or for specific device
flutter run -d <device-id>
```

### Testing the App

1. **Sign Up**: Create a new account
2. **Login**: Use your credentials
3. **Add Lamp**: Click the "+" button
4. **Enter Data**: Add lamp name, temperature, and humidity
5. **View Colors**: See color indicators change based on values

### Color Meanings

**Temperature (°C):**
- 🟢 Green: 20-24°C (Perfect)
- 🟡 Yellow: 18-20°C or 24-26°C (Normal)
- 🔴 Red: < 18°C or > 26°C (Bad)

**Humidity (%):**
- 🟢 Green: 40-60% (Perfect)
- 🟡 Yellow: 35-40% or 60-70% (Normal)
- 🔴 Red: < 35% or > 70% (Bad)

### Features

✅ User Authentication (Sign up/Login)
✅ Add/Delete Lamps
✅ Real-time Temperature & Humidity Display
✅ Color-coded Status Indicators
✅ Firebase Firestore Database
✅ User Per-lamp Data Storage
✅ Responsive UI with Material Design 3
✅ Smooth Animations & Gradients

### Troubleshooting

**"Cannot connect to Firebase"**
- Verify firebase_options.dart has correct credentials
- Check internet connection
- Ensure Firestore is enabled in Firebase Console

**"Authentication failed"**
- Verify email/password are correct
- Check Email/Password auth is enabled in Firebase

**"App crashes on startup"**
- Run `flutter clean`
- Run `flutter pub get`
- Check Android/iOS SDK versions match flutter requirements

**"Build fails"**
- Delete build folders: `flutter clean`
- Run: `flutter pub get`
- Try again: `flutter run`

### Project Structure

```
lamp_app/
├── lib/
│   ├── main.dart                 # App entry & auth routing
│   ├── firebase_options.dart     # Firebase config (UPDATE THIS)
│   ├── models/
│   │   ├── lamp_data.dart       # Lamp data structure
│   │   └── user_model.dart      # User data structure
│   ├── services/
│   │   ├── firebase_service.dart # Firebase operations
│   │   └── color_service.dart    # Color logic for values
│   ├── screens/
│   │   ├── login_screen.dart    # Login UI
│   │   ├── signup_screen.dart   # Sign up UI
│   │   └── home_screen.dart     # Dashboard UI
│   └── widgets/
│       └── sensor_card.dart      # Sensor display card
├── android/                      # Android files
├── ios/                          # iOS files
└── pubspec.yaml                  # Dependencies
```

### Key Dependencies

- `firebase_core`: Firebase initialization
- `firebase_auth`: User authentication
- `cloud_firestore`: Cloud database
- `provider`: State management
- `animations`: UI animations

### Next Steps

1. ✅ Set up Firebase Project
2. ✅ Add credentials to `firebase_options.dart`
3. ✅ Run `flutter pub get`
4. ✅ Run `flutter run`
5. Create test account
6. Add sample lamps with test data
7. Integrate with real IoT devices (add API connections)
8. Deploy to App Store/Play Store

### Connecting Real Devices

To connect real IoT devices:
1. Create device data upload API
2. Update `lib/services/firebase_service.dart` to accept device data
3. Set automatic data refresh intervals
4. Add push notifications for alerts

---

**Need Help?**
- Flutter Docs: https://docs.flutter.dev
- Firebase Docs: https://firebase.google.com/docs
- Stack Overflow: Tag your questions with flutter & firebase

Happy monitoring! 🚀
