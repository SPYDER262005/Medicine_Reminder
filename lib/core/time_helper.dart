import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeHelper {
  // Get time of day period (Morning, Afternoon, Evening, Night)
  static String getTimeOfDayPeriod(DateTime time) {
    final hour = time.hour;
    
    if (hour >= 6 && hour < 12) {
      return 'Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Evening';
    } else {
      return 'Night';
    }
  }
  
  // Format time in 12-hour format with AM/PM
  static String format12Hour(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }
  
  // Get IconData for time of day period
  static IconData getTimeOfDayIcon(String period) {
    switch (period) {
      case 'Morning':
        return Icons.wb_twilight_rounded;
      case 'Afternoon':
        return Icons.wb_sunny_rounded;
      case 'Evening':
        return Icons.nights_stay_rounded;
      case 'Night':
        return Icons.dark_mode_rounded;
      default:
        return Icons.access_time_rounded;
    }
  }
  
  // Get time range text for period
  static String getTimeRangeText(String period) {
    switch (period) {
      case 'Morning':
        return '6:00 AM - 12:00 PM';
      case 'Afternoon':
        return '12:00 PM - 5:00 PM';
      case 'Evening':
        return '5:00 PM - 9:00 PM';
      case 'Night':
        return '9:00 PM - 6:00 AM';
      default:
        return '';
    }
  }
  
  // Get medicine type IconData
  static IconData getMedicineTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pill':
      case 'tablet':
      case 'capsule':
        return Icons.medication_rounded;
      case 'syrup':
        return Icons.water_drop_rounded;
      case 'injection':
        return Icons.vaccines_rounded;
      case 'cream':
        return Icons.opacity_rounded;
      default:
        return Icons.medication_rounded;
    }
  }

  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}
