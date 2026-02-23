# 💊 Medicine Reminder App - Project Report

**Project Title:** Medibuddy - Smart Medication Management System  
**Developed By:** Prathamesh Renose  
**Academic Year:** 2025-2026  
**Institution:** [Your Institution Name]  
**Platform:** Flutter (Android, iOS, Web, Desktop)  
**Backend:** Firebase (Auth, Firestore) & Hive (Offline)

---

## 📄 Abstract
Medibuddy is a comprehensive healthcare solution designed to assist patients in managing their daily medication schedules. In today’s fast-paced life, missing a dose of medication can have serious health consequences, especially for those with chronic illnesses like diabetes or hypertension. This application provides a robust, user-friendly interface to schedule reminders for various types of medicines (tablets, syrups, injections, and creams), track stock levels, and store crucial safety information like allergies and doctor notes.

---

## 1. Introduction
### 1.1 Overview
The Medicine Reminder App is a cross-platform mobile application developed using the Flutter framework. It serves as a personal health assistant that ensures users never miss their prescribed doses.

### 1.2 Problem Statement
Patients often forget to take their medicines on time due to:
- Busy work schedules.
- Complex prescription routines (multiple medicines at different times).
- Physical weakness or cognitive decline in elderly patients.

### 1.3 Objectives
- To provide timely notifications for medication.
- To store detailed medicine information including safety guidelines.
- To allow cloud synchronization for data persistence.
- To provide an Admin side for healthcare monitoring.

---

## 2. Technical Stack
### 2.1 Frontend: Flutter & Dart
- **Flutter:** Used for building the natively compiled cross-platform application.
- **Dart:** The underlying programming language offering high performance.
- **Flutter Animate:** Used for smooth UI transitions and micro-interactions.

### 2.2 Backend & Storage
- **Firebase Auth:** Handles secure user login and registration.
- **Cloud Firestore:** Real-time NoSQL database for cloud sync.
- **Hive:** Lightweight and fast local database for offline-first capabilities.
- **Local Notifications:** Advanced scheduling of reminders with action buttons.

---

## 3. Key Features
### 3.1 User Application
- **Categorization:** Organize medicines by type (Tablets, Syrups, Injections, Creams).
- **Smart Scheduling:** Support for daily reminders and custom weekly schedules.
- **Stock Management:** Visual alerts when medicine stock is low.
- **Safety Vault:** Store information about side effects, warnings, and allergies.
- **Doctor Directory:** Keep track of doctors and their specific instructions for each medicine.

### 3.2 Admin Panel (Web)
- **Dashboard Analytics:** View total users and active medications.
- **Global Inventory:** Monitor and manage the list of all medicines added to the system.
- **User Management:** Oversee user activity to ensure system integrity.

---

## 4. System Design
### 4.1 Database Architecture (Firestore)
- **Users Collection:** Stores user profile data.
- **Medicines Sub-collection:** Each user has a unique set of medicines.
- **Logs Collection:** Tracks history of 'Taken' vs 'Missed' doses.

### 4.2 UI/UX Design Principles
- **Aesthetic:** Clean, medical-themed color palette (#009688 Teal).
- **Accessibility:** Large fonts and high-contrast icons for elderly users.
- **Interactivity:** Swipe-to-delete and interactive graphs.

---

## 5. Implementation (Key Snippets)

### 5.1 Notification Logic
```dart
static Future<void> scheduleNotification(int id, String title, String body, DateTime time) async {
  // Logic for daily repeating reminders
  await _notifications.zonedSchedule(
    id, title, body, scheduleTime, 
    notificationDetails, 
    matchDateTimeComponents: DateTimeComponents.time
  );
}
```

### 5.2 Stock Alert Logic
```dart
bool isLowStock(Medicine m) => m.stock <= m.lowStockThreshold;
```

---

## 6. Testing & Results
- **Unit Testing:** Verified time conversion and scheduling logic.
- **UI Testing:** Ensured responsiveness across Mobile and Web views.
- **User Acceptance:** Successfully tested by small group of simulated patients.

---

## 7. Future Scope
- **AI Prescription Scanner:** Extracting medicine data from camera photos.
- **Family Sharing:** Allowing caregivers to monitor a patient’s dose history.
- **Voice Integration:** Reminders via Google Assistant or Alexa.
- **Drug Interaction Checker:** Alerting users if two medicines clash.

---

## 8. Conclusion
The Medicine Reminder App successfully addresses the challenge of medication adherence. By combining offline speed with cloud reliability, it provides a dependable tool for patients and healthcare providers alike.

---

## 9. References
- Flutter Documentation: https://docs.flutter.dev
- Firebase Guide: https://firebase.google.com/docs
- Medical Informatics Research Papers.

---
© 2026 Prathamesh Renose. All Rights Reserved.
