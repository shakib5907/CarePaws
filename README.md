# CarePaws

A cross-platform pet care application built with Flutter and Firebase.

## Features

- User authentication (sign up and login via Firebase Auth)
- Pet and user data stored in Cloud Firestore
- Local session persistence with Shared Preferences
- Runs on Android, Web, Windows, macOS, and Linux

## Tech Stack

- **Flutter** — cross-platform UI framework
- **Firebase Auth** — user authentication
- **Cloud Firestore** — cloud database
- **Shared Preferences** — local data persistence
- **Google Fonts** — custom typography

## Prerequisites

- Flutter SDK `^3.10.4`
- A [Firebase](https://firebase.google.com/) project

## Getting Started

1. Clone the repository

   ```bash
   git clone https://github.com/shakib5907/CarePaws.git
   cd CarePaws
   ```

2. Install dependencies

   ```bash
   flutter pub get
   ```

3. Configure Firebase

   - Create a project in the [Firebase Console](https://console.firebase.google.com/)
   - Place `google-services.json` inside `android/app/`
   - Place `GoogleService-Info.plist` inside `ios/Runner/`
   - Enable **Email/Password Authentication** and **Cloud Firestore** in the console

4. Run the app

   ```bash
   flutter run
   ```

## Project Structure

```
CarePaws/
├── lib/              # Dart source code
├── Asset/            # Images and icons
├── android/
├── ios/
├── web/
├── windows/
├── macos/
├── linux/
└── test/
```
