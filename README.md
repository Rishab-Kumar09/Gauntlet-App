# Gauntlet App

A Flutter application with Firebase authentication and Firestore database integration.

## Features

- ✅ Firebase Authentication (Google Sign-In & Email/Password)
- ✅ Cloud Firestore Database
- ✅ Cross-platform support (Web, Android, iOS)
- ✅ Professional FirebaseUI authentication screens
- ✅ Auth state persistence (stay signed in)
- ✅ Real-time database connection testing

## Prerequisites

Before you begin, ensure you have installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.38.4 or higher)
- [Git](https://git-scm.com/downloads)
- A code editor (VS Code, Android Studio, or IntelliJ)
- For Android: Android Studio with Android SDK
- For iOS: Xcode (Mac only)

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Rishab-Kumar09/Gauntlet-App.git
cd Gauntlet-App
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Set Up Firebase

#### Create `.env` file

Create a `.env` file in the root directory with your Firebase credentials:

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

**⚠️ IMPORTANT:** Never commit the `.env` file to Git! It contains sensitive credentials.

#### Firebase Console Setup

Your Firebase admin needs to:

1. **Enable Authentication Methods:**
   - Go to Firebase Console → Authentication → Sign-in method
   - Enable "Google" provider
   - Enable "Email/Password" provider

2. **Add SHA Certificates (for Android):**
   - Get your SHA-1 certificate:
     ```bash
     cd android
     ./gradlew signingReport
     ```
   - Copy the SHA-1 and SHA-256 values
   - Add them in Firebase Console → Project Settings → Your apps → Android app → SHA certificate fingerprints

## Running the App

### Web (Recommended for Development)

```bash
flutter run -d chrome
# or
flutter run -d edge
```

### Android

```bash
flutter run
# Select your Android device or emulator
```

### iOS

```bash
flutter run
# Select your iOS device or simulator
```

## Project Structure

```
lib/
├── main.dart          # Main application entry point
android/               # Android-specific code
ios/                   # iOS-specific code
web/                   # Web-specific code
test/                  # Unit tests
.env                   # Environment variables (DO NOT COMMIT)
pubspec.yaml           # Dependencies configuration
```

## Dependencies

Key packages used:

- `firebase_core` - Firebase initialization
- `firebase_auth` - Firebase authentication
- `cloud_firestore` - Firestore database
- `firebase_ui_auth` - Pre-built auth UI screens
- `firebase_ui_oauth_google` - Google Sign-In integration
- `flutter_dotenv` - Environment variables

## Development

### Hot Reload

While the app is running, press:
- `r` - Hot reload (quick)
- `R` - Hot restart (full restart)
- `q` - Quit

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## Troubleshooting

### Chrome Launch Issues

If Chrome fails to launch, try using Edge:
```bash
flutter run -d edge
```

### Android Google Sign-In Not Working

1. Ensure SHA-1 certificate is added to Firebase Console
2. Check that Google Sign-In is enabled in Firebase Authentication
3. Make sure `google-services.json` is in `android/app/` directory

### Profile Picture Not Loading on Web

This is a CORS issue with localhost during development. Profile pictures will work:
- ✅ On production domains
- ✅ On Android/iOS apps
- ✅ On Edge browser (usually)

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is private and managed by the organization.

## Support

For issues or questions, contact the development team.

---

**Built with Flutter 💙**
