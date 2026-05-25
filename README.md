# 🐾 CarePaws

A cross-platform pet care mobile application built with **Flutter** and **Firebase**. CarePaws helps pet owners manage their pets' health and care information from a single, intuitive app.

---

## ✨ Features

- 🔐 **User Authentication** — Secure sign-up and login powered by Firebase Authentication
- 🗄️ **Cloud Data Storage** — Pet and user data stored in real-time with Cloud Firestore
- 💾 **Local Preferences** — App settings and session data persisted with Shared Preferences
- 🎨 **Custom Typography** — Beautiful UI powered by Google Fonts
- 📱 **Cross-Platform** — Runs on Android, iOS, Web, Windows, macOS, and Linux

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| [Flutter](https://flutter.dev) | Cross-platform UI framework |
| [Dart](https://dart.dev) | Programming language |
| [Firebase Auth](https://firebase.google.com/products/auth) | User authentication |
| [Cloud Firestore](https://firebase.google.com/products/firestore) | NoSQL cloud database |
| [Firebase Core](https://firebase.google.com/docs/flutter/setup) | Firebase SDK initialisation |
| [Shared Preferences](https://pub.dev/packages/shared_preferences) | Local data persistence |
| [Google Fonts](https://pub.dev/packages/google_fonts) | Custom font integration |

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `^3.10.4`
- [Dart SDK](https://dart.dev/get-dart) `^3.10.4`
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter extension
- A [Firebase](https://firebase.google.com/) project

---

### 🔧 Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/shakib5907/CarePaws.git
   cd CarePaws
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   - Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
   - Register your Android and/or iOS app.
   - Download the config files and place them:
     - `google-services.json` → `android/app/`
     - `GoogleService-Info.plist` → `ios/Runner/`
   - Enable **Firebase Authentication** (Email/Password) and **Cloud Firestore** in the console.

4. **Run the app**

   ```bash
   flutter run
   ```

---

## 📁 Project Structure

```
CarePaws/
├── android/          # Android platform files
├── ios/              # iOS platform files
├── linux/            # Linux platform files
├── macos/            # macOS platform files
├── web/              # Web platform files
├── windows/          # Windows platform files
├── lib/              # Main Dart source code
├── Asset/            # App assets (images, icons)
│   ├── SplashScreen_image.png
│   ├── login.png
│   └── register.png
├── test/             # Unit and widget tests
├── pubspec.yaml      # Project dependencies
└── firebase.json     # Firebase configuration
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.2.1
  cupertino_icons: ^1.0.8
  firebase_core: ^3.15.2
  firebase_auth: ^5.5.3
  cloud_firestore: ^5.6.12
  shared_preferences: ^2.3.2
```

---

## 🤝 Contributing

Contributions are welcome! To get started:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

---

## 📄 License

This project is open source. Feel free to use and modify it.

---

## 👤 Author

**Shakib** — [@shakib5907](https://github.com/shakib5907)

---

> Made with ❤️ and Flutter
