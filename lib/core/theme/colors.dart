import 'package:flutter/material.dart';

class AppColors {
  // Seed Colors
  static const Color pastelPink = Color(0xFFFFB7B2);
  static const Color orange = Color(0xFFFF9F0A);
  static const Color violet = Color(0xFFAF52DE);

  // Default Seed
  static const Color seedColor = pastelPink;

  // Brand Colors (Dynamic based on seed, but keeping defaults for reference)
  static const Color primary = Color(0xFFFF9AA2);
  static const Color secondary = Color(0xFFC7CEEA);
  static const Color tertiary = Color(0xFFFFDAC1);

  // Accent Colors
  static const Color accent1 = Color(0xFFE2F0CB);
  static const Color accent2 = Color(0xFFB5EAD7);

  // Light Theme Colors
  static const Color backgroundLight = Color(0xFFFFF9FA);
  static const Color surfaceLight = Colors.white;
  static const Color onBackgroundLight = Color(0xFF4A4A4A);
  static const Color onSurfaceLight = Color(0xFF4A4A4A);

  // Dark Theme Colors
  static const Color backgroundDark = Color(0xFF1C1C1E);
  static const Color surfaceDark = Color(0xFF2C2C2E);
  static const Color onBackgroundDark = Color(0xFFEAEAEA);
  static const Color onSurfaceDark = Color(0xFFEAEAEA);

  // Semantic Colors
  static const Color error = Color(0xFFFF6961);
  static const Color success = Color(0xFF77DD77);
}
