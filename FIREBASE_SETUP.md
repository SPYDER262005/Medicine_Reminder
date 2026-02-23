# 🔥 Firebase & Security Rules Setup Guide

This guide explains how to connect your **Medicine Reminder App** to Firebase and secure your data.

---

## 1. Firebase Console Setup
1.  Go to [Firebase Console](https://console.firebase.google.com/).
2.  Create a new project named `Medicine-Reminder`.
3.  Enable **Authentication**:
    *   Go to Build > Authentication.
    *   Click "Get Started" and enable **Email/Password**.
4.  Enable **Cloud Firestore**:
    *   Go to Build > Firestore Database.
    *   Click "Create Database".
    *   Choose a location and start in **Test Mode** (we will update rules below).

---

## 2. Platform Configuration
### 📱 Android
1.  Click the Android icon in Project Overview.
2.  Package name: `com.example.medicine_reminder` (Check `android/app/build.gradle`).
3.  Download `google-services.json` and place it in `android/app/`.

### 🌐 Web (For Admin Panel)
1.  Click the Web icon (</>).
2.  App nickname: `Medicine Admin`.
3.  Copy the `firebaseConfig` object.
4.  Run `flutterfire configure` in the `admin_panel` directory if you have local CLI, or manually update the initialization in `main.dart`.

---

## 3. Firestore Security Rules
Copy and paste these rules into the **Firestore > Rules** tab to ensure users can only see their own data, while Admins (or global queries) are handled correctly.

```javascript
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    
    // User-specific data
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Global medicines collection (for Admin)
    match /medicines/{medicineId} {
      // Allow read if user is authenticated (or add admin-specific UID check)
      allow read: if request.auth != null;
      // Allow write if the user is saving their own medicine
      allow create, update: if request.auth != null && request.resource.data.userId == request.auth.uid;
      // Allow delete if the user owns the medicine
      allow delete: if request.auth != null && resource.data.userId == request.auth.uid;
    }
  }
}
```

---

## 4. Dependencies
Ensure these are in your `pubspec.yaml`:
```yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
```

---

## 5. Verification
1.  Register a new user in the app.
2.  Add a medication.
3.  Check the Firebase Console > Firestore tab. You should see a new `users` document and a global `medicines` document!
