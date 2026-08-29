# QUICK START - Lamp Monitor App

## 🚀 Get Running in 5 Minutes

### Prerequisites
- Flutter SDK installed
- Firebase account (free)
- Android Studio / Xcode (for emulator)

### Step 1: Firebase Setup (2 min)
```
1. Go to firebase.google.com → Console
2. Create new project named "lamp-monitor"
3. Enable Authentication (Email/Password)
4. Create Firestore Database
5. Download google-services.json (Android) or GoogleService-Info.plist (iOS)
```

### Step 2: App Configuration (1 min)
```
1. Place google-services.json in: android/app/
2. Update lib/firebase_options.dart with your Firebase credentials
   (Copy values from google-services.json or Firebase Console)
```

### Step 3: Install & Run (2 min)
```bash
cd lamp_app
flutter pub get
flutter run
```

### Step 4: Test the App
```
1. Sign up with any email/password
2. Click + to add a lamp
3. Enter: Lamp name, temperature (16-30), humidity (20-80)
4. Watch colors change based on values!
```

---

## 🎨 Color Indicators Quick Reference

| Metric | Perfect | Normal | Bad |
|--------|---------|--------|-----|
| Temp | 20-24°C (🟢) | 18-20°C, 24-26°C (🟡) | <18°C, >26°C (🔴) |
| Humidity | 40-60% (🟢) | 35-40%, 60-70% (🟡) | <35%, >70% (🔴) |

---

## 📁 Project Files to Know

| File | Purpose |
|------|---------|
| `lib/main.dart` | App start + auth routing |
| `lib/firebase_options.dart` | Firebase credentials (UPDATE THIS!) |
| `lib/screens/login_screen.dart` | Login UI |
| `lib/screens/home_screen.dart` | Dashboard with lamp cards |
| `lib/services/firebase_service.dart` | Database operations |
| `lib/services/color_service.dart` | Color logic (green/yellow/red) |
| `android/app/build.gradle` | Firebase dependencies |

---

## 🔧 Firebase Firestore Structure

After first signup, your database looks like:
```
firestore/
└─ users/
   └─ {your_uid}/
      ├── email: "user@example.com"
      ├── displayName: "John"
      ├── createdAt: 2024-01-01...
      └─ lamps/
         └─ {lampId}/
            ├── lampName: "Living Room Lamp"
            ├── temperature: 22.5
            ├── humidity: 55.0
            ├── timestamp: 2024-01-01...
            └── status: "online"
```

---

## ✅ Checklist Before Running

- [ ] Firebase project created
- [ ] Authentication enabled (Email/Password)
- [ ] Firestore database created  
- [ ] google-services.json in android/app/
- [ ] Firebase credentials in lib/firebase_options.dart
- [ ] `flutter pub get` completed
- [ ] Emulator/device connected

---

## 🎯 Recommended Test Values

**Perfect Temperature**: 22°C (green)
**Perfect Humidity**: 50% (green)
**Warm**: 25°C (yellow)
**Too Hot**: 28°C (red)
**Too Dry**: 30% (red)
**Too Humid**: 75% (red)

---

## 🐛 Common Issues

| Issue | Solution |
|-------|----------|
| Firebase not found | Check google-services.json path |
| Sign up fails | Enable Email/Password in Firebase |
| Crashes on startup | Run `flutter clean` then `flutter pub get` |
| Build errors | Update Android SDK to API 31+ |

---

## 📱 Built-in Features

✅ User signup/login
✅ Add multiple lamps
✅ Real-time monitoring
✅ Auto-color based on values
✅ Delete lamps
✅ Logout
✅ Cloud backup (Firestore)
✅ Beautiful Material UI

---

## 🚀 Next Steps

1. **Run the app** - Test with dummy data
2. **Create accounts** - Try login/signup
3. **Add IoT integration** - Connect real sensors
4. **Add notifications** - Alert on bad values
5. **Deploy** - Publish to Play Store/App Store

**Enjoy!** 🎉
