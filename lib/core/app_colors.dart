import 'package:flutter/material.dart';

class AppColors {
  // Primary Teal - Stronger for visibility
  static const primary = Color(0xFF00796B);
  static const primaryLight = Color(0xFF4DB6AC);
  static const primaryDark = Color(0xFF004D40);
  static const primaryExtraLight = Color(0xFFB2DFDB);

  // Accent Colors
  static const accent = Color(0xFFFF9800);
  static const secondary = Color(0xFF00897B);

  // Background & Surface - Common Mint Color everywhere
  static const background = Color(0xFFE0F2F1); // Main common color
  static const surface = Color(0xFFF1F8F7); // Slightly different for cards
  static const cardBackground = Color(0xFFFFFFFF);

  // Dashboard Surface
  static const surfaceMint = Color(0xFFD1EAE5);

  // Login Inputs (Using dark theme from screenshots)
  static const darkSurface = Color(0xFF212C2C);
  static const darkInput = Color(0xFF1C2525);

  // Ensure "Dark Mode" also uses Mint as common color
  static const backgroundDark = Color(0xFFE0F2F1);
  static const surfaceDark = Color(0xFFF1F8F7);

  // Text Colors - Deeper and Bold for maximum visibility
  static const textPrimary = Color(0xFF002929); // Near black teal
  static const textSecondary = Color(0xFF2D4F4F);
  static const textHint = Color(0xFF708E8E);

  static const textPrimaryDark = Color(0xFF002929);
  static const textSecondaryDark = Color(0xFF2D4F4F);

  // Medicine Category Colors
  static const List<Color> medicineColors = [
    Color(0xFF00796B), // Teal
    Color(0xFF0288D1), // Blue
    Color(0xFFFF9800), // Orange
    Color(0xFFD32F2F), // Red
    Color(0xFF558B2F), // Green
    Color(0xFF7B1FA2), // Purple
  ];

  // Semantic Colors
  static const success = Color(0xFF2E7D32);
  static const error = Color(0xFFC62828);
  static const warning = Color(0xFFFBC02D);
  static const info = Color(0xFF0277BD);

  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF00897B), Color(0xFF004D40)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppSpacing {
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 16.0;
  static const double l = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}
