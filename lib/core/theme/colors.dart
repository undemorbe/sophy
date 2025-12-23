import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF5E5CE6); // A nice violet/blue
  static const Color secondary = Color(0xFF32D74B); // A vibrant green for accents
  static const Color tertiary = Color(0xFFFF9F0A); // Orange for highlights

  // Light Theme Colors
  static const Color backgroundLight = Color(0xFFF2F2F7);
  static const Color surfaceLight = Colors.white;
  static const Color onBackgroundLight = Colors.black;
  static const Color onSurfaceLight = Colors.black;

  // Dark Theme Colors
  static const Color backgroundDark = Color(0xFF000000);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color onBackgroundDark = Colors.white;
  static const Color onSurfaceDark = Colors.white;

  // Semantic Colors
  static const Color error = Color(0xFFFF453A);
  static const Color success = Color(0xFF30D158);
  
  // Chat Specific
  static const Color myMessageBubbleLight = Color(0xFF5E5CE6);
  static const Color otherMessageBubbleLight = Color(0xFFE5E5EA);
  static const Color myMessageBubbleDark = Color(0xFF5E5CE6);
  static const Color otherMessageBubbleDark = Color(0xFF2C2C2E);
}
