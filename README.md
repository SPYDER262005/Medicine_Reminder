<div align="center">

<img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
<img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
<img src="https://img.shields.io/badge/Firebase-Auth%20%26%20Firestore-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />
<img src="https://img.shields.io/badge/Hive-Local%20DB-FF7043?style=for-the-badge&logo=databricks&logoColor=white" />
<img src="https://img.shields.io/badge/Platform-Android%20|%20iOS%20|%20Web-blueviolet?style=for-the-badge" />

<br/><br/>

# 💊 MedAlert — Smart Medicine Reminder

### *Never miss a dose again.*

**MedAlert** is a premium, cross-platform Flutter application that helps users manage their medicines, track dose history, store health records, and consult doctor information — all powered by Firebase and a clean, modern UI.

<br/>

---

</div>

## 📸 App Overview

> MedAlert delivers a clinical yet beautiful UI, smart scheduling, local push notifications, and Firebase-backed authentication — making it your personal health companion.

---

## ✨ Features

### 🔐 Authentication
- **Firebase Email/Password** login & registration
- **Auth state persistence** — users stay logged in across sessions
- **Onboarding screen** for first-time users
- Smart `AuthWrapper` to route users to the correct screen

### 💊 Medicine Management
- Add, edit, and delete medicines with rich metadata:
  - Name, dosage, frequency, category, stock count, expiry date
- **Multiple categories**: Tablets, Capsules, Syrup, Injection, Vitamins, First Aid, Herbs, Tests, and more
- Set **custom reminder times** per medicine
- Swipe-to-delete with **Flutter Slidable**

### 🔔 Smart Push Notifications
- Local notifications via **`flutter_local_notifications`**
- Scheduled reminders using **`timezone`** package
- Custom alarm screen with a snooze/dismiss flow

### 📅 Schedule & History
- Full **monthly calendar view** (30/31 days) of scheduled doses
- View medicines due for any selected day
- **Dose Logs** tracking taken/skipped status with timestamps
- **History Screen** with detailed dose records

### 📊 Reports & Analytics
- Visual reports of adherence and missed doses
- Summary of weekly/monthly medication compliance

### 🩺 Doctors & Appointments
- Store doctor contact information
- Log and manage upcoming appointments
- Quick-access emergency contact screen

### 🏥 Health Records
- Add and manage personal health records
- Track vitals, lab results, and medical notes

### ℹ️ More Features
- **Health Guide** with medicine tips and information
- **Emergency Screen** with quick-dial access
- Dark mode & Light mode support (system-adaptive)
- Admin panel (separate sub-project)

---

## 🏗️ Project Architecture

```
medicine_reminder/
├── lib/
│   ├── main.dart                  # App entry point, Firebase & Hive init
│   ├── firebase_options.dart      # Auto-generated Firebase config
│   │
│   ├── core/
│   │   ├── app_theme.dart         # Light & Dark Theme definitions
│   │   └── notification_service.dart  # Local push notification setup
│   │
│   ├── models/
│   │   ├── medicine_model.dart    # Medicine data model (Hive)
│   │   ├── doctor_model.dart      # Doctor data model (Hive)
│   │   ├── health_record_model.dart
│   │   ├── dose_log_model.dart    # Dose history logs (Hive)
│   │   └── appointment_model.dart
│   │
│   ├── providers/
│   │   ├── medicine_provider.dart
│   │   ├── doctor_provider.dart
│   │   ├── health_record_provider.dart
│   │   ├── history_provider.dart
│   │   └── appointment_provider.dart
│   │
│   ├── screens/
│   │   ├── onboarding_screen.dart
│   │   ├── auth_screen.dart
│   │   ├── home_screen.dart
│   │   ├── add_medicine_screen.dart
│   │   ├── medicine_detail_screen.dart
│   │   ├── schedule_screen.dart
│   │   ├── history_screen.dart
│   │   ├── reports_screen.dart
│   │   ├── doctors_screen.dart
│   │   ├── health_records_screen.dart
│   │   ├── alarm_screen.dart
│   │   ├── emergency_screen.dart
│   │   ├── health_guide_screen.dart
│   │   ├── category_screen.dart
│   │   └── more_screen.dart
│   │
│   ├── services/
│   │   └── auth_service.dart      # Firebase Auth logic
│   │
│   └── widgets/                   # Reusable UI components
│
├── admin_panel/                   # Separate Flutter admin sub-project
├── android/                       # Android-specific config
├── ios/                           # iOS-specific config
├── web/                           # Web-specific config
└── pubspec.yaml
```

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| **Flutter 3.x** | Cross-platform UI framework |
| **Dart 3.x** | Programming language |
| **Firebase Auth** | User authentication |
| **Cloud Firestore** | Cloud database |
| **Hive + Hive Flutter** | Fast local NoSQL database |
| **Provider** | State management |
| **flutter_local_notifications** | Local push notifications |
| **timezone** | Accurate time-zone-aware scheduling |
| **flutter_slidable** | Swipe actions on list items |
| **google_fonts** | Premium typography |
| **flutter_animate** | Smooth, declarative animations |
| **lottie** | Animated illustrations |
| **intl** | Date & time formatting |
| **url_launcher** | Open links, phone calls |
| **uuid** | Unique ID generation |

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) `>=3.x`
- [Dart SDK](https://dart.dev/get-dart) `>=3.x`
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- A Firebase project (see [Firebase Setup](#-firebase-setup))

---

### 1. Clone the Repository

```bash
git clone https://github.com/SPYDER262005/Medicine_Reminder.git
cd Medicine_Reminder
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

> ⚠️ You must configure Firebase before running the app.

1. Go to [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. Enable **Authentication** → Email/Password sign-in method.
3. Enable **Cloud Firestore**.
4. Register your app (Android / iOS / Web) and download the config files:
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`
5. Run the FlutterFire CLI to generate `firebase_options.dart`:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

See [`FIREBASE_SETUP.md`](./FIREBASE_SETUP.md) for detailed instructions.

### 4. Run Code Generation (Hive Adapters)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5. Run the App

```bash
# Run on connected Android/iOS device
flutter run

# Run on Chrome (Web)
flutter run -d chrome

# Run on Windows desktop
flutter run -d windows
```

---

## 📦 Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

---

## 🔑 Environment & Configuration

| File | Purpose |
|---|---|
| `firebase_options.dart` | Auto-generated Firebase platform config |
| `android/app/google-services.json` | Android Firebase config |
| `ios/Runner/GoogleService-Info.plist` | iOS Firebase config |

> **⚠️ Never commit `google-services.json` or `GoogleService-Info.plist` to a public repository.**

Make sure these are listed in your `.gitignore`.

---

## 🗂️ State Management

This app uses the **Provider** pattern for all state management:

| Provider | Responsibility |
|---|---|
| `MedicineProvider` | CRUD for medicines, scheduling reminders |
| `HistoryProvider` | Dose logs and taken/skipped status |
| `DoctorProvider` | Doctor contact management |
| `HealthRecordProvider` | Health record CRUD |
| `AppointmentProvider` | Appointment scheduling |

---

## 🌐 Supported Platforms

| Platform | Status |
|---|---|
| ✅ Android | Fully supported |
| ✅ iOS | Fully supported |
| ✅ Web (Chrome) | Fully supported |
| ✅ Windows | Supported |
| ✅ macOS | Supported |
| ✅ Linux | Supported |

---

## 📁 Admin Panel

The `admin_panel/` directory contains a **separate Flutter project** for administrative management of the Medicine Reminder backend. Navigate into it and run independently:

```bash
cd admin_panel
flutter pub get
flutter run
```

---

## 📑 Additional Documentation

| Document | Description |
|---|---|
| [`FIREBASE_SETUP.md`](./FIREBASE_SETUP.md) | Step-by-step Firebase configuration |
| [`PROJECT_REPORT.md`](./PROJECT_REPORT.md) | Detailed project report and design decisions |
| [`PRESENTATION_OUTLINE.md`](./PRESENTATION_OUTLINE.md) | Presentation guide and talking points |

---

## 🤝 Contributing

Contributions are welcome! Here's how to get started:

1. **Fork** the repository
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes and **commit**:
   ```bash
   git commit -m "feat: add your feature"
   ```
4. **Push** to your branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a **Pull Request**

Please follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for commit messages.

---

## 🛡️ License

This project is licensed under the **MIT License**.  
See the [LICENSE](./LICENSE) file for details.

---

## 👨‍💻 Author

<div align="center">

**Prathmesh Renose**

[![GitHub](https://img.shields.io/badge/GitHub-SPYDER262005-181717?style=for-the-badge&logo=github)](https://github.com/SPYDER262005)

*Built with ❤️ using Flutter & Firebase*

</div>

---

<div align="center">

⭐ **If you found this project helpful, please give it a star!** ⭐

</div>
