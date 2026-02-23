import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> init() async {
    if (kIsWeb) return;

    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: android,
      iOS: ios,
      macOS: ios,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        if (details.payload != null) {
          debugPrint('Notification payload: ${details.payload}');
          // Logic for handling "Take" or "Snooze" from action buttons
          if (details.actionId == 'take_action') {
            debugPrint('Medicine Taken from Notification');
            // In a real app, use a service or provider to update DB
          } else if (details.actionId == 'snooze_action') {
            snooze(details.id ?? 999, 'Medicine Reminder', 'Snoozed alert', 10);
          }
        }
      },
    );
    _initialized = true;
  }

  static Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime time, {
    bool isCritical = false,
  }) async {
    if (!_initialized || kIsWeb) return;

    final now = DateTime.now();
    var scheduleTime = tz.TZDateTime.from(time, tz.local);

    if (scheduleTime.isBefore(now)) {
      scheduleTime = scheduleTime.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduleTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          isCritical ? 'critical_medicine_channel' : 'medicine_channel',
          isCritical ? 'Critical Reminders' : 'Medicine Reminders',
          channelDescription: 'Notifications for medicine reminders',
          importance: isCritical ? Importance.max : Importance.high,
          priority: isCritical ? Priority.max : Priority.high,
          fullScreenIntent: isCritical,
          playSound: true,
          actions: <AndroidNotificationAction>[
            const AndroidNotificationAction(
              'take_action',
              'TAKE NOW',
              showsUserInterface: true,
              cancelNotification: true,
            ),
            const AndroidNotificationAction(
              'snooze_action',
              'SNOOZE (10m)',
              showsUserInterface: false,
              cancelNotification: true,
            ),
          ],
        ),
        iOS: const DarwinNotificationDetails(
          categoryIdentifier: 'medicine_actions',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'med_id_$id',
    );
  }

  static Future<void> snooze(
    int id,
    String title,
    String body,
    int minutes,
  ) async {
    final now = DateTime.now();
    final snoozeTime = now.add(Duration(minutes: minutes));
    // Schedule a one-time snooze
    await _notifications.zonedSchedule(
      id +
          1000, // Use different ID to avoid conflict with recurring notification
      title + ' (Snoozed)',
      body,
      tz.TZDateTime.from(snoozeTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'snooze_channel',
          'Snoozed Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelNotification(int id) async {
    if (!_initialized || kIsWeb) return;
    await _notifications.cancel(id);
  }
}
