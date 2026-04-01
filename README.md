# 🌿 Plant Detection App

> A cross-platform Flutter application that leverages AI and Firebase to detect plant diseases, helping farmers and gardeners identify issues early and take action.

---

## 📖 Project Overview

**Plant Detection** is a mobile and desktop Flutter application that allows users to capture or upload images of plants and receive AI-powered disease detection results. The app integrates Firebase services for authentication, cloud storage, and real-time data management — providing a seamless experience from photo capture to diagnosis.

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter (Dart) |
| **Backend / Auth** | Firebase Authentication |
| **Database** | Cloud Firestore |
| **File Storage** | Firebase Storage |
| **HTTP Client** | `http` package |
| **Image Handling** | `image_picker` |
| **Local Storage** | `shared_preferences` |
| **Path Resolution** | `path_provider` |
| **Network Info** | `network_info_plus` |
| **Permissions** | `permission_handler` |
| **UI Scaling** | `flutter_screenutil` |
| **Internationalization** | `intl` |

---

## 🏗️ Architecture

The project follows a **feature-first, layered architecture** with clear separation of concerns:

```
plant_detection/
├── lib/
│   ├── firebase_options.dart       # Firebase platform config (auto-generated)
│   └── ...                         # Feature screens, widgets, services
├── assets/                         # Static assets (images, icons, etc.)
├── android/                        # Android-specific configuration
├── ios/                            # iOS-specific configuration
├── windows/                        # Windows desktop support
├── firebase.json                   # Firebase project configuration
└── pubspec.yaml                    # Dependencies & project metadata
```

**Data flow:**

1. User captures/selects a plant image via `image_picker`
2. The image is uploaded to **Firebase Storage**
3. An HTTP request is made to an AI/ML inference endpoint
4. Results are stored in **Cloud Firestore** and displayed to the user
5. User authentication is handled end-to-end via **Firebase Auth**

---

## ✨ Features

- 📸 **Image Capture & Upload** — Pick from gallery or take a photo directly in-app
- 🔍 **AI-Powered Disease Detection** — Send images to an ML model and receive disease predictions
- 🔐 **User Authentication** — Secure sign-up and login via Firebase Auth (email/password and social providers)
- ☁️ **Cloud Storage** — All images are stored securely in Firebase Storage
- 📋 **Scan History** — Diagnosis results persisted in Firestore per user
- 📡 **Network Awareness** — Detects connectivity status using `network_info_plus`
- 💾 **Local Preferences** — App settings and session data saved with `shared_preferences`
- 📱 **Responsive UI** — Scales seamlessly across phones and tablets using `flutter_screenutil`
- 🌍 **Multi-platform** — Runs on Android, iOS, and Windows

---

## 🧪 Testing

The project includes integration tests across the key Firebase service plugins:

- **Firestore integration tests** — Cover CRUD operations, query filtering, cursors, transactions, batch writes, and aggregate queries
- **Firebase Auth tests** — Cover sign-in flows, user management, multi-factor authentication, and provider linking
- **Firebase Storage tests** — Cover upload tasks, download URLs, metadata management, and reference operations
- **Path Provider tests** — Verify platform-specific directory resolution on Windows

To run unit tests:

```bash
flutter test
```

To run integration tests on a connected device:

```bash
flutter test integration_test/
```

---

## 📁 Folder Structure

```
plant_detection/
├── android/
│   └── app/
│       ├── google-services.json    # Firebase Android config
│       └── src/main/
├── assets/                         # App assets (images, etc.)
├── ios/
│   └── Runner/
├── lib/
│   ├── firebase_options.dart       # Multi-platform Firebase options
│   └── main.dart                   # App entry point
├── windows/
│   └── flutter/ephemeral/
│       └── .plugin_symlinks/       # Platform plugin symlinks
├── analysis_options.yaml           # Dart/Flutter lint rules
├── firebase.json                   # Firebase CLI project config
└── pubspec.yaml                    # Package dependencies
```

---

## 🚀 How to Run the Project

### Prerequisites

- Flutter SDK `^3.7.2` installed — [Get Flutter](https://docs.flutter.dev/get-started/install)
- Dart SDK included with Flutter
- A Firebase project configured (see `firebase.json` and `firebase_options.dart`)
- Android Studio or VS Code with Flutter/Dart extensions

### Steps

**1. Clone the repository**

```bash
git clone https://github.com/your-username/plant_detection.git
cd plant_detection
```

**2. Install dependencies**

```bash
flutter pub get
```

**3. Configure Firebase**

Ensure the following files are present and correct for your Firebase project:

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`

You can regenerate these using the FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

**4. Run the app**

```bash
# Android or iOS
flutter run

# Windows desktop
flutter run -d windows
```

---

## 🔮 Future Improvements

- 🤖 **On-device ML** — Integrate TFLite or ONNX for offline inference without server dependency
- 🌐 **Multi-language support** — Expand localization beyond English using the existing `intl` setup
- 📊 **Analytics Dashboard** — Add Firebase Analytics to track usage patterns and popular detections
- 🔔 **Push Notifications** — Alert users when scan results are ready (via Firebase Messaging)
- 🌱 **Plant Encyclopedia** — Add a browsable database of common plant diseases with treatment guides
- 🗺️ **Disease Heatmaps** — Visualize disease outbreak trends by geographic region
- 🧪 **Automated CI/CD** — Set up GitHub Actions for automated testing and deployment
- 🎨 **Custom Theming** — Add dark mode and user-configurable color themes

---

## 📸 Screenshots

> _Screenshots will be added here once the UI is finalized._

| Home Screen | Capture / Upload | Diagnosis Results |
|---|---|---|
| <img width="430" height="932" alt="After adding photo" src="https://github.com/user-attachments/assets/f43aabd8-0001-45e8-8e9a-17f45c3051a9" /> | <img width="430" height="932" alt="Capture" src="https://github.com/user-attachments/assets/0bb91b50-f32a-4576-b09d-ab74fdd197de" /> | <img width="430" height="1781" alt="Detection Results" src="https://github.com/user-attachments/assets/1bc483c8-53db-431f-8822-991ef9599467" /> |

---

## 🔗 Social Links

| Platform | Link |
|---|---|
| 🐙 GitHub | [github.com/manarghareeb/plant_detection](https://github.com/manarghareeb) |
| 💼 LinkedIn | [linkedin.com/in/your-profile](https://linkedin.com/in/manar-ghareeb) |
| 📧 Email | manarghareeb1973@example.com |

---

<p align="center">Made with ❤️ using Flutter & Firebase</p>
