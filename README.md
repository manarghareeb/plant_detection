<div align="center">

# 🌿 Plant Detection App

**An AI-powered Flutter application for plant disease detection — snap or upload a leaf photo, and get instant diagnosis results including plant type, health status, disease name, and confidence score, all backed by a Python ML backend.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7+-0175C2?logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore%20%7C%20Storage-FFCA28?logo=firebase)](https://firebase.google.com)
[![Python](https://img.shields.io/badge/ML%20Backend-Python%20Flask-3776AB?logo=python)](https://flask.palletsprojects.com)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0.0-orange)]()

</div>

---

## 📖 Project Overview

**Plant Detection** is an AI-powered mobile application that helps farmers, gardeners, and plant enthusiasts diagnose plant diseases instantly using their smartphone camera. The app connects to a custom **Python Flask ML backend** that receives the plant image, runs it through a trained machine learning model, and returns a full diagnosis report in real time.

The app supports **Firebase Authentication** for user management, **Cloud Firestore** for storing user profiles, and **Firebase Storage** for profile photo uploads. Users can capture or upload plant images, view detailed detection results, browse plant categories, and review their past diagnosis history — all in a clean, green-themed UI.

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| **Framework** | Flutter (Dart 3.7+) |
| **Authentication** | Firebase Auth |
| **Database** | Cloud Firestore |
| **File Storage** | Firebase Storage |
| **ML Backend** | Python Flask REST API (`/predict` endpoint) |
| **HTTP Client** | http (multipart file upload) |
| **Image Handling** | image_picker (Camera + Gallery) |
| **Permissions** | permission_handler |
| **Local Storage** | SharedPreferences (auth state persistence) |
| **Network Info** | network_info_plus |
| **UI Scaling** | flutter_screenutil |
| **Date Formatting** | intl |
| **File System** | path_provider |

---

## 🏗️ Architecture

The project follows a **feature-first folder structure** with a shared `core` layer. Each screen is organized by feature, keeping views, widgets, and business logic cleanly separated.

```
lib/
├── core/                         # Shared across all features
│   ├── Helper/                   # AuthService (login state + Firebase auth check)
│   ├── Models/                   # HistoryItem model + HistoryManager (in-memory store)
│   ├── theme/                    # AppTheme (primary, secondary, background colors)
│   └── widgets/                  # Shared UI components
│
└── features/                     # Feature-first modules
    ├── authentication/           # Login, Register, Forget Password, Edit Profile, Logout
    ├── home/                     # Home screen + bottom navigation shell
    ├── plant_detection/          # Capture, Upload, Detection Results, Plant Diagnosis
    └── history/                  # Detection history list
```

**Key architectural decisions:**

- **`AuthService`** centralizes login state management — it checks both `SharedPreferences` (persisted flag) and `FirebaseAuth.currentUser` before deciding the initial route. This prevents stale login states after token expiry.
- **`HistoryManager`** is a static in-memory store that persists detection results across screens within a session, recording the scanned image, disease name, and timestamp for each diagnosis.
- **Firebase + Python Flask hybrid backend** — Firebase handles identity and user data; the Python ML model handles all plant disease inference. The Flutter app sends images via `http.MultipartRequest` to the `/predict` Flask endpoint.
- **Detection results schema** — the ML backend returns a structured JSON with `validity`, `confidence`, `health`, `plant_type`, and `disease` fields, all displayed in a result card.
- **Route-based initialization** — `main()` checks login state asynchronously and sets `initialRoute` to either `/home` or `/login` before the app renders.

---

## ✨ Features

### 🔐 Authentication
- Email/password registration and login via **Firebase Auth**
- Forget password with email-based recovery
- Login state persisted in `SharedPreferences` — user stays logged in across app restarts
- Dual-check login validation: both SharedPreferences flag and live Firebase user token
- Full logout with Firebase sign-out and state clearing

### 👤 User Profile
- Edit profile screen: update display name and profile photo
- Profile photo uploaded to **Firebase Storage** and URL stored in **Cloud Firestore**
- Real-time name fetch from Firestore displayed in the home screen app bar

### 🏠 Home Dashboard
- Personalized greeting with the user's name fetched from Firestore
- Plant category list view for browsing plant types
- Uploaded image card — shows the last captured image with a "Start Detection" button
- Start Detection placeholder shown when no image is uploaded yet
- Quick access to Edit Profile and Logout via the app bar menu

### 📸 Capture Screen
- Take a real-time photo using the device **camera**
- Pick an existing image from the **gallery**
- Storage permission handled gracefully with user feedback via SnackBar
- Captured image passed back to the home screen and immediately ready for detection

### 📤 Upload Screen
- Grid view of all images captured/uploaded in the current session
- 2-column responsive grid layout with `BoxFit.cover` display

### 🔬 Detection Results (AI Diagnosis)
- Image is sent to the **Python Flask ML backend** via multipart POST request
- Detection auto-starts on screen load (`initState`)
- Results displayed in a structured card showing:
  - ✅ **Image Validity** — whether the image is a valid plant photo
  - ✅ **Confidence Score** — model certainty as a percentage
  - ✅ **Health Status** — healthy or diseased
  - ✅ **Plant Type** — identified plant species
  - ✅ **Disease Name** — specific disease detected (or "None")
- Result is automatically saved to `HistoryManager` after successful detection
- Error states handled and displayed if the backend is unreachable

### 📋 Detection History
- Chronological list of all detection results from the current session
- Each history item shows the scanned image thumbnail, disease name, and formatted timestamp
- Collapsible section with expand/collapse toggle
- Empty state message when no history exists yet
- Timestamps formatted with `intl` DateFormat (e.g., `12 Apr 2026   03:45 PM`)

### 🧭 Bottom Navigation
- 4-tab navigation: **Home**, **Upload**, **Capture**, **History**
- Rounded top corners with custom primary color accent
- Bottom glow shadow effect (`BottomNavShadow`) for a polished UI touch

---

## 🧪 Testing

The project uses Flutter's built-in testing framework with linting via `flutter_lints`.

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

Run all tests:

```bash
flutter test
```

**Recommended test additions:**

- Unit tests for `AuthService` (mocking SharedPreferences and FirebaseAuth)
- Unit tests for `HistoryManager` (add, clear, retrieve items)
- Widget tests for `DetectionResultsScreen` (mock HTTP responses, verify result card rendering)
- Integration tests for the full capture → send → display results flow

---

## 📁 Folder Structure

```
plant_detection/
├── lib/
│   ├── core/
│   │   ├── Helper/
│   │   │   └── auth_service.dart         # Login state + Firebase session checks
│   │   ├── Models/
│   │   │   └── model.dart                # HistoryItem + HistoryManager (in-memory)
│   │   ├── theme/
│   │   │   └── const_themes.dart         # AppTheme colors (primary, secondary, background)
│   │   └── widgets/
│   │       ├── bottom_nav_shadow.dart    # Glowing bottom nav border effect
│   │       ├── custom_buttom_widget.dart # Reusable primary button with loading state
│   │       └── custom_text_form_field.dart # Text field with show/hide password toggle
│   │
│   ├── features/
│   │   ├── authentication/
│   │   │   └── presentation/
│   │   │       ├── views/
│   │   │       │   ├── login_screen.dart
│   │   │       │   ├── register_screen.dart
│   │   │       │   ├── forget_password_screen.dart
│   │   │       │   ├── edit_profile_screen.dart  # Firebase Storage photo upload
│   │   │       │   └── logout_screen.dart
│   │   │       └── widgets/
│   │   │           └── auth_navigation_text.dart  # "Already have an account?" text link
│   │   │
│   │   ├── home/
│   │   │   └── presentation/
│   │   │       ├── views/
│   │   │       │   ├── home_screen.dart               # Dashboard with Firestore user data
│   │   │       │   └── bottom_navigation_bar_screen.dart # 4-tab navigation shell
│   │   │       └── widgets/
│   │   │           ├── home_app_bar.dart              # App bar with user name + menu
│   │   │           ├── category_list_view.dart        # Horizontal plant categories
│   │   │           ├── category_item.dart             # Single category chip
│   │   │           ├── uploaded_image_card.dart       # Image preview + Start Detection btn
│   │   │           ├── start_detection_placeholder.dart # Empty state prompt
│   │   │           └── floating_action_button_widget.dart
│   │   │
│   │   ├── plant_detection/
│   │   │   └── presentation/
│   │   │       └── views/
│   │   │           ├── capture_screen.dart            # Camera + Gallery picker
│   │   │           ├── detection_results_screen.dart  # ML results display + history save
│   │   │           ├── plant_diagnosis_screen.dart    # Alternative diagnosis flow
│   │   │           └── upload_screen.dart             # Grid of uploaded images
│   │   │
│   │   └── history/
│   │       └── presentation/
│   │           └── views/
│   │               └── history_screen.dart            # Detection history list
│   │
│   ├── firebase_options.dart                          # FlutterFire generated config
│   └── main.dart                                      # App entry, auth state check, routing
│
├── assets/                                            # App assets
├── android/                                           # Android native project
├── ios/                                               # iOS native project
├── pubspec.yaml                                       # Dependencies & assets manifest
└── README.md
```

---

## 🚀 How to Run the Project

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.7.2`
- Dart `>=3.7.2`
- Android Studio / VS Code with Flutter & Dart extensions
- A physical Android device or emulator with camera support
- Python 3.8+ for the ML backend
- A Firebase project with Auth, Firestore, and Storage enabled

### Steps

**1. Clone the repository**

```bash
git clone https://github.com/your-username/plant_detection.git
cd plant_detection
```

**2. Install Flutter dependencies**

```bash
flutter pub get
```

**3. Configure Firebase**

- Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
- Enable **Email/Password Authentication**, **Firestore**, and **Firebase Storage**
- Download `google-services.json` → place in `android/app/`
- The `firebase_options.dart` file is already generated

**4. Start the Python ML Backend**

```bash
# In your Python ML project directory:
pip install flask tensorflow pillow numpy
python app.py
```

The Flask server should start at `http://0.0.0.0:5000` and expose the `/predict` endpoint.

**5. Update the backend IP address**

In `lib/features/plant_detection/presentation/views/detection_results_screen.dart`, update the server IP to match your machine's local IP address:

```dart
final uri = Uri.parse("http://<YOUR_LOCAL_IP>:5000/predict");
```

> Both your phone and your PC must be on the **same Wi-Fi network**.

**6. Run the app**

```bash
flutter run
```

**7. Build release APK**

```bash
flutter build apk --release
```

---

## 🌐 Backend API

The Flutter app communicates with a local Python Flask server running the plant disease ML model.

| Endpoint | Method | Body | Response |
|----------|--------|------|----------|
| `/predict` | `POST` | `multipart/form-data` with `image` field | JSON with detection results |

**Example response:**

```json
{
  "validity": "Valid",
  "confidence": 0.9732,
  "health": "Diseased",
  "plant_type": "Tomato",
  "disease": "Early Blight"
}
```

> The backend server IP must be updated in the app to match your development machine's local network IP before running.

---

## 🔮 Future Improvements

- [ ] **Cloud ML Backend** — Deploy the Flask model to a cloud server (AWS, GCP, or Render) so users don't need a local server
- [ ] **Persistent History** — Save detection history to **Cloud Firestore** so it survives app restarts
- [ ] **Disease Details Page** — Tap on a result to see a full description, treatment recommendations, and prevention tips
- [ ] **Multiple Plant Categories** — Filter detection by plant type for more targeted diagnosis
- [ ] **Offline Mode** — Cache recent results for offline viewing
- [ ] **Dark Mode** — Full dark theme support
- [ ] **Multi-Language (i18n)** — Support for Arabic, English, and other languages
- [ ] **Social Sharing** — Share diagnosis results as an image or PDF report
- [ ] **Unit & Widget Tests** — Comprehensive test coverage for AuthService, HistoryManager, and screens
- [ ] **CI/CD Pipeline** — Automated testing and APK builds via GitHub Actions

---

## 📸 Screenshots

> Add your screenshots here to showcase the app's UI.

| Home | Upload Grid | Plant Categories |
|:----:|:-----------:|:----------------:|
| ![home](https://github.com/user-attachments/assets/60666936-2785-47ed-a78f-c13442645443) | ![upload](https://github.com/user-attachments/assets/1118e2a2-3de7-4ad9-ade6-a4f577ea36a5) |![after upload image](https://github.com/user-attachments/assets/fd02c163-3c59-4b25-b5d7-14e648acc3f1) |

| Capture | Detection Results | History |
|:-------:|:-----------------:|:-------:|
| ![galary](https://github.com/user-attachments/assets/521fbf2f-0b8b-4a43-ab19-92c6f5f8ec25) | ![result detection](https://github.com/user-attachments/assets/b89fe4cc-e669-4a6d-b916-f0b78bcde825) | ![history](https://github.com/user-attachments/assets/b3c05c86-c1d2-4e2a-b30c-6ef869746fd1) |

---

## 🤝 Contributing

Contributions are very welcome! Here's how to get started:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'feat: add your feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Open a Pull Request

Please make sure `flutter analyze` passes with no warnings before submitting.

---

## 📬 Social Links

<div align="center">

[![GitHub](https://img.shields.io/badge/GitHub-@manarghareeb-181717?logo=github)](https://github.com/manarghareeb)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?logo=linkedin)](https://linkedin.com/in/manar-ghareeb)
[![Email](https://img.shields.io/badge/Email-Contact%20Me-D14836?logo=gmail)](mailto:manarghareeb@gmail.com)

</div>

---

<div align="center">

Made with ❤️ and Flutter · Keeping plants healthy, one leaf at a time 🌱

</div>
