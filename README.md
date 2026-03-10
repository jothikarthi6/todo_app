# ✅ Todo App — Flutter + Firebase + Hive + Riverpod

A clean, production-ready **To-Do List App** built with Flutter, featuring Firebase Authentication, Firebase Realtime Database, Hive local caching, and Riverpod state management.

---

## 📱 Screenshots

<img width="140" height="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-10 at 12 39 37" src="https://github.com/user-attachments/assets/659c97c7-272c-4c43-8e97-d53e799ec0e1" />
<img width="140" height="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-10 at 12 40 04" src="https://github.com/user-attachments/assets/14206b8a-8637-42d8-ad0d-6fb6aa017e53" />
<img width="140" height="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-10 at 12 28 52" src="https://github.com/user-attachments/assets/5276089c-56de-413d-89bb-d5f56440ccab" />
<img width="140" height="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-10 at 12 29 27" src="https://github.com/user-attachments/assets/8bf2283a-0ee5-4294-80f2-4d7a6a8300e1" />
<img width="140" height="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-10 at 12 29 00" src="https://github.com/user-attachments/assets/7fc46064-ddc2-4b45-9b1e-2c7b540cc8c4" />
<img width="140" height="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-10 at 12 30 06" src="https://github.com/user-attachments/assets/9dbab17e-596a-4b18-a324-021d93b1fad5" />
<img width="140" height="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-10 at 12 33 55" src="https://github.com/user-attachments/assets/0d340466-24bd-4b04-84a0-e65fbe9f470e" />

> _Add your simulator/device screenshots here_

---

## 🚀 Features

- 🔐 **User Authentication** — Secure Sign Up & Login via Firebase Auth (Email/Password)
- 📋 **Task Management** — Add, Edit, Delete, and Mark tasks as Complete
- 🔄 **Real-time Sync** — Tasks sync instantly with Firebase Realtime Database
- 💾 **Offline Support** — Tasks cached locally using Hive for offline access
- 🎯 **State Management** — Efficient state handling with Riverpod
- 🔍 **Task Filtering** — Filter tasks by All / Active / Completed
- 📱 **Responsive UI** — Adapts to all screen sizes and orientations
- 🎨 **Clean UI** — Dark header + white card design inspired by modern mobile UI

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Authentication | Firebase Auth (Email/Password) |
| Cloud Database | Firebase Realtime Database |
| Local Cache | Hive |
| State Management | Riverpod |
| Fonts | Google Fonts (Poppins) |

---

## 📁 Project Structure

```
lib/
├── main.dart                        # App entry point
├── firebase_options.dart            # Firebase configuration
├── models/
│   ├── task_model.dart              # Hive task model
│   └── task_model.g.dart            # Auto-generated Hive adapter
├── providers/
│   ├── auth_provider.dart           # Auth state providers
│   └── task_provider.dart           # Task state providers + filters
├── screens/
│   ├── splash_screen.dart           # Auth state router
│   ├── auth/
│   │   ├── login_screen.dart        # Login UI
│   │   └── signup_screen.dart       # Sign Up UI
│   └── home/
│       ├── home_screen.dart         # Main task list screen
│       └── add_edit_task_sheet.dart # Add / Edit task bottom sheet
├── services/
│   ├── auth_service.dart            # Firebase Auth methods
│   └── task_service.dart            # CRUD operations (Firebase + Hive)
└── theme/
    └── app_theme.dart               # Colors, fonts, theme config
```

---

## ⚙️ Setup & Installation

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Firebase account
- Xcode (for iOS) / Android Studio (for Android)
- CocoaPods (for iOS)

---

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/todo_app.git
cd todo_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project
3. Add **Android** and/or **iOS** app
4. Enable **Authentication → Email/Password**
5. Create **Realtime Database** (Test mode)
6. Download config files:
   - Android → `google-services.json` → place in `android/app/`
   - iOS → `GoogleService-Info.plist` → place in `ios/Runner/`

### 4. Configure `firebase_options.dart`

Update `lib/firebase_options.dart` with your Firebase project values:

```dart
static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'YOUR_API_KEY',
  appId: 'YOUR_APP_ID',
  messagingSenderId: 'YOUR_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  databaseURL: 'https://YOUR_PROJECT-default-rtdb.firebaseio.com',
  storageBucket: 'YOUR_PROJECT.appspot.com',
  iosClientId: 'YOUR_IOS_CLIENT_ID',
  iosBundleId: 'com.yourname.todoApp',
);
```

### 5. Generate Hive Adapters

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 6. Run the App

```bash
# iOS Simulator
flutter run

# Specific device
flutter run -d "iPhone 15 Pro"

# Release build
flutter build apk --release        # Android APK
flutter build ios --release        # iOS
```

---

## 🔥 Firebase Realtime Database Rules

```json
{
  "rules": {
    "users": {
      "$uid": {
        ".read": "$uid === auth.uid",
        ".write": "$uid === auth.uid"
      }
    }
  }
}
```

---

## 📦 Dependencies

```yaml
dependencies:
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  firebase_database: ^11.1.4
  flutter_riverpod: ^2.5.1
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  google_fonts: ^6.2.1

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.11
```

---

## 🏗️ Architecture

```
UI (Screens)
    ↓
Providers (Riverpod)        ← State Management
    ↓
Services (Auth + Task)      ← Business Logic
    ↓
Firebase Auth               ← Authentication
Firebase Realtime DB        ← Cloud Storage
Hive                        ← Local Cache / Offline
```

---

## 🔐 Security

- All tasks are stored under the authenticated user's UID
- Firebase rules prevent users from accessing each other's data
- Passwords are handled entirely by Firebase Auth (never stored locally)
- `google-services.json` and `GoogleService-Info.plist` are excluded from version control

---

## 📄 .gitignore Important Entries

```
# Firebase config files — DO NOT commit these
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
lib/firebase_options.dart

# Build outputs
build/
*.apk
```

---

## 👨‍💻 Author

**Your Name**
- GitHub: [@jothikarthi6](https://github.com/jothikarthi6)
- Email: jothikarthi6@gmail.com

---

## 📝 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

_Built with ❤️ using Flutter & Firebase_
