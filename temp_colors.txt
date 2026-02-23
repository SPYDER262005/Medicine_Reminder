import 'package:flutter/material.dart';

class AppColors {
  // Primary Teal Colors
  static const primary = Colors.teal;
  static const primaryLight = Color(0xFF4DB6AC);
  static const primaryDark = Color(0xFF00796B);
  static const primaryExtraLight = Color(0xFFB2DFDB);
  
  // Accent Orange Colors
  static const accent = Colors.orange;
  static const accentLight = Color(0xFFFFB74D);
  static const accentDark = Color(0xFFF57C00);
  
  // Background & Surface
  static const background = Color(0xFFF5F5F5);
  static const surface = Colors.white;
  static const cardBackground = Colors.white;
  
  // Text Colors
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const textHint = Color(0xFFBDBDBD);
  
  // Medicine Category Colors (Teal/Orange variations)
  static const List<Color> medicineColors = [
    Color(0xFF009688), // Teal
    Color(0xFF00ACC1), // Cyan
    Color(0xFFFF9800), // Orange
    Color(0xFFFF6F00), // Deep Orange
    Color(0xFF26A69A), // Teal Light
    Color(0xFFFFA726), // Orange Light
  ];
  
  // Semantic Colors
  static const success = Color(0xFF4CAF50);
  static const error = Color(0xFFF44336);
  static const warning = Color(0xFFFFC107);
  
  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF009688), Color(0xFF00796B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const accentGradient = LinearGradient(
    colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
