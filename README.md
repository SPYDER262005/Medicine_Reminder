# 💊 MedAlert – Smart Medicine Reminder (Pro Edition)

**MedAlert** is a high-performance, production-ready, and visually stunning medicine reminder application built with **Flutter** and **Firebase**. Designed with a focus on **Clean, Safe, and Trustworthy** UI/UX, it ensures you never miss a dose again.

![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-blue)
![Flutter](https://img.shields.io/badge/Flutter-v3.10+-02569B?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Integrated-FFCA28?logo=firebase)
![Design](https://img.shields.io/badge/Design-Material_3-009688)

---

## 📖 Project Overview
MedAlert is the ultimate health companion for patients and caregivers. It combines **local-first reliability (Hive)** with **instant cloud synchronization (Firebase)** to provide a seamless experience across all your devices—mobile, tablet, and desktop.

---

## 🔥 Professional Design System
| Property | Value | HEX |
| :--- | :--- | :--- |
| **Primary** | Teal (Trust & Health) | `#009688` |
| **Secondary** | Light Blue (Calmness) | `#81D4FA` |
| **Accent** | Vibrant Orange (Alerts) | `#FF9800` |
| **Background** | Pure White | `#FFFFFF` |
| **Text** | Dark Grey (Readability) | `#263238` |

**Typography**: Poppins (Modern, Friendly, Highly Readable)  
**Spacing**: Standardized Grid System (4px, 8px, 16px, 24px, 32px, 48px)

---

## ✨ Features List
- **🔐 Secure Authentication**: Multi-platform Email/Password auth via Firebase.
- **🔄 Real-time Cloud Sync**: Automatic synchronization across Android, iOS, and Web.
- **💾 Local-First Architecture**: Works 100% offline using Hive database.
- **� SOS Emergency Button**: Instant access to emergency help on the home screen.
- **📊 Daily Habit Tracking**: Modern toggles to mark doses as taken with habit reset.
- **🔍 Intelligent Search**: Filter medications instantly as you type.
- **⏰ Smart Multi-platform Notifications**: Reliable background reminders for all devices.
- **💡 Daily Health Tips**: Built-in motivation and wellness advice.
- **🌓 Adaptive Theme**: Support for Light and Dark modes with system synchronization.

---

## 📱 Supported Platforms
| Platform | Status | Features |
| :--- | :---: | :--- |
| **Android** | ✅ Stable | Material 3, Notifications, Auth, Sync |
| **iOS** | ✅ Stable | Cupertino style, Notifications, Auth, Sync |
| **Web** | ✅ Stable | Responsive layout, PWA Support, Auth, Sync |
| **Desktop** | ✅ Stable | Native Windows/macOS UI, Auth, Sync |

---

## � Installation & Setup
1. **Clone the Repo:**
   ```bash
   git clone https://github.com/PRATHMESH-RENOSE/MedAlert.git
   ```
2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```
3. **Generate Adapters (Critical):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

---

## 🔥 Firebase Configuration
1. Create a project in [Firebase Console](https://console.firebase.google.com/).
2. Enable **Authentication** (Email/Password).
3. Enable **Firestore Database** (Real-time Sync).
4. Run `flutterfire configure` to set up all platforms instantly.

---

## 🎯 Future Roadmap (Project Enhancements)

To make **MedAlert** even more powerful and "project-worthy," the following enhancements are planned:

### 🚀 1. Smart Reminder System
- **Multiple Times per Day**: Support for Morning / Afternoon / Night reminders (e.g., 8 AM, 2 PM, 9 PM).
- **Snooze Option**: Ability to snooze alerts for 5, 10, or 15 minutes.
- **Missed Dose Alert**: Automatic notification if a medicine is not marked as taken.
- **Repeat Schedule**: Flexible scheduling for Daily / Weekly / Custom days.

### 📊 2. Medicine History & Reports
- **Dose History**: Detailed dashboard showing taken vs. missed medicines.
- **Weekly/Monthly Report**: Visual charts for tracking adherence trends.
- **Export Report (PDF)**: Generate professional PDF reports to share with doctors.

### ☁️ 3. Cloud Backup & Sync
- **Advanced Login System**: Integration with Google/Email login via Firebase.
- **Multi-Device Sync**: Real-time synchronization between Mobile, Web, and Desktop.

### 🧠 4. AI & Smart Features
- **Medicine Suggestions**: AI-driven suggestions based on past dosage patterns.
- **Health Tips AI**: Personalized health tips and wellness advice.
- **Symptom Tracking**: Log and track pain, fever, BP, and sugar levels.

### 💊 5. Medicine Management
- **Stock Management**: Track the quantity of pills remaining.
- **Low Stock Alert**: Smart alerts like “Only 3 pills left.”
- **Expiry Reminder**: Proactive warnings before medicine expiration.

### 👨‍⚕️ 6. Doctor & Emergency Support
- **Doctor Profiles**: Save and manage doctor contact information.
- **Appointment Reminders**: Schedule and get notified for upcoming doctor visits.
- **Medical Profile**: Quick access to blood group, allergies, and chronic conditions.

### 🎨 7. UI / UX Enhancements
- **Multi-Language Support**: Support for English, Hindi, and Marathi (e.g., *औषध घ्यायची वेळ झाली आहे*).
- **Voice Assistant**: Integrated "Voice Reminders" for elderly users.
- **Custom Themes**: Allow users to select their own color schemes.

---

## 📝 Future Scope (For Project Report)

> "The future scope of **MedAlert** involves integrating advanced cloud services for seamless data synchronization and backup. We aim to implement an AI-based health monitoring system that provides personalized insights and symptom tracking. Additionally, multi-language support (English, Hindi, Marathi) will be added to enhance accessibility for diverse users. Future versions will also include a comprehensive medicine stock management system, a dedicated doctor consultation module, and integration with smart wearable devices for real-time health monitoring and emergency SOS alerts."

---

## 📞 Developer Details
**Prathmesh Renose**  
Flutter Developer  
[GitHub Profile](https://github.com/PRATHMESH-RENOSE) | [LinkedIn Profile](https://linkedin.com/in/prathmeshrenose)

---
Made with ❤️ by **PRATHMESH RENOSE**
