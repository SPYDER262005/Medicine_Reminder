# Medicine Reminder App

A Flutter-based Medicine Reminder application developed as an assignment submission. This app allows users to manage their medication schedules with a focus on clean code, proper state management, and a strict **Teal & Orange** design aesthetic.

## 📱 Features

- **Home Screen**: 
  - Displays a list of medicines sorted by time (e.g., Morning meds before Evening meds).
  - Shows placeholder text when the list is empty.
  - Grouped by time of day (Morning, Afternoon, Evening, Night).
- **Add Medicine**: 
  - Simple form with validation (prevents saving empty forms).
  - Time Picker for precise scheduling.
  - Medicine Type selection (Pill, Bottle, Syringe, Tablet).
- **Alarm & Notifications**: 
  - Triggers background notifications/alarms at the scheduled time.
  - Works even when the app is closed.
- **Local Storage**: 
  - Uses **Hive** for fast, persistent, server-less data storage.
- **Design**: 
  - **Primary**: Teal
  - **Accents**: Orange
  - Modern, clean UI with edit/delete swipe actions.

## 🛠️ Tech Stack & Architecture

- **Framework**: Flutter
- **State Management**: **Provider** (Separating UI from Logic).
- **Storage**: **Hive** (No backend required).
- **Notifications**: `flutter_local_notifications`.
- **Architecture**: distinct separation of concerns:
  - `lib/screens`: UI Components.
  - `lib/providers`: Business Logic & State.
  - `lib/models`: Data Structures.
  - `lib/core`: Services (Notifications, Time Helpers).

## 🚀 Getting Started

1. **Clone the repository**:
   ```bash
   git clone <repository_url>
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   ```bash
   flutter run
   ```

## 📸 Assignment Requirements Checklist

- [x] **Home Screen**: List sorted by time with details.
- [x] **Add Screen**: Form with Time Picker & Validation.
- [x] **Alarm Logic**: Background notifications implemented.
- [x] **Local Storage**: Implemented using Hive.
- [x] **Design**: Strictly Teal (Primary) & Orange (Accent).
- [x] **Code Quality**: Clean structure, no excessive `setState`.

## License

This project is for assignment submission purposes.
