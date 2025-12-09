# Gauntlet App

A Flutter application with Firebase authentication and Firestore database integration.

## Quick Start

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- A code editor (VS Code recommended)

### Run the App (Web)

1. **Clone the repository:**
```bash
git clone https://github.com/Rishab-Kumar09/Gauntlet-App.git
cd Gauntlet-App
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Create `.env` file** in the root directory:
```env
FIREBASE_API_KEY=your_api_key_here
FIREBASE_AUTH_DOMAIN=your_auth_domain_here
FIREBASE_PROJECT_ID=your_project_id_here
FIREBASE_STORAGE_BUCKET=your_storage_bucket_here
FIREBASE_MESSAGING_SENDER_ID=your_sender_id_here
FIREBASE_APP_ID=your_app_id_here

ENVIRONMENT=development
TELESIGN_ENABLED=true
RAPIDAPI_KEY=your_rapidapi_key_here
```

> **⚠️ Note:** Get Firebase credentials from your project admin. Never commit the `.env` file!

4. **Run the app:**
```bash
flutter run -d chrome
# or if Chrome has issues:
flutter run -d edge
```

That's it! The app should open in your browser.

## Features

- ✅ Google Sign-In & Email/Password authentication
- ✅ Cloud Firestore database
- ✅ Cross-platform (Web, Android, iOS)
- ✅ Auto sign-in persistence

## Running on Mobile

### Android
```bash
flutter run
```
**Note:** Android requires additional Firebase setup (SHA certificates). Contact your admin for configuration.

### iOS
```bash
flutter run
```
**Note:** Requires Xcode on Mac.

## Development Tips

**Hot Reload:** While running, press `r` in the terminal for instant updates!

**Chrome Issues?** Use Edge instead:
```bash
flutter run -d edge
```

## Tech Stack

- Flutter 3.38.4
- Firebase (Auth + Firestore)
- FirebaseUI Auth

## Need Help?

Contact the development team for:
- Firebase credentials
- Android setup (SHA certificates)
- Production deployment

---

**Built with Flutter 💙**
