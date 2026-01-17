# Medicine Reminder App

A Flutter-based Medicine Reminder application designed to help users manage their medication schedules effectively. The app features a clean, modern user interface with a Teal and Orange color scheme and supports local storage and background notifications.

## Features

- **Add Medicines**: Easily add medicines with details like name, dosage, and type (Pill, Bottle, Syringe, Tablet).
- **Time Picker**: Select precise times for reminders.
- **Medicine Types**: Visual selectors for different types of medicines.
- **Color Coding**: Organized UI with a consistent Teal and Orange theme.
- **Local Storage**: Uses Hive for efficient and persistent local data storage.
- **Background Notifications**: Reliable alarm system to remind users even when the app is closed.
- **Home Screen Grouping**: Medicines are grouped by time of day (Morning, Afternoon, Evening, Night).
- **Edit & Delete**: Swipe to delete medicines or tap to edit details.
- **Notes**: Add optional notes for each medicine.

## Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Provider
- **Local Storage**: Hive
- **Notifications**: flutter_local_notifications (or android_alarm_manager_plus)

## Getting Started

### Prerequisites

- Flutter SDK installed
- Android/iOS Emulator or Physical Device

### Installation

1. Clone the repository:
   ```bash
   git clone <repository_url>
   ```
2. Navigate to the project directory:
   ```bash
   cd Medicine_Reminder
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Folder Structure

- `lib/core`: Core utilities and services (NotificationService, TimeHelper).
- `lib/models`: Data models (Medicine).
- `lib/providers`: State management providers (MedicineProvider).
- `lib/screens`: UI screens (HomeScreen, AddMedicineScreen).
- `lib/widgets`: Reusable widgets (MedicineTypeSelector, etc.).
- `lib/main.dart`: Entry point of the application.

## Screenshots

*(Add screenshots of your app here)*

## License

This project is licensed under the MIT License.
