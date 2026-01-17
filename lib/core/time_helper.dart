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
  
  // Get icon for time of day period
  static String getTimeOfDayIcon(String period) {
    switch (period) {
      case 'Morning':
        return '🌅';
      case 'Afternoon':
        return '☀️';
      case 'Evening':
        return '🌆';
      case 'Night':
        return '🌙';
      default:
        return '⏰';
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
  
  // Get medicine type icon
  static String getMedicineTypeIcon(String type) {
    switch (type) {
      case 'Tablet':
        return '💊';
      case 'Capsule':
        return '💊';
      case 'Syrup':
        return '🧪';
      case 'Injection':
        return '💉';
      default:
        return '💊';
    }
  }
}
