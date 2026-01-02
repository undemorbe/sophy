import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'fonts.dart';

class AppTheme {
  static ThemeData getTheme({
    required Brightness brightness,
    Color seedColor = AppColors.pastelPink,
  }) {
    final isDark = brightness == Brightness.dark;

    // Generate ColorScheme from seed
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
      surface: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      onSurface: isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight,
    );

    // Override specific colors to ensure contrast and style
    final finalColorScheme = colorScheme.copyWith(
      surfaceContainerHighest: isDark
          ? const Color(0xFF2C2C2E)
          : const Color(0xFFF2F2F7),
      outline: isDark ? Colors.white24 : Colors.black12,
    );

    final backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final onBackgroundColor = isDark
        ? AppColors.onBackgroundDark
        : AppColors.onBackgroundLight;

    return ThemeData(
      useMaterial3: true,
      colorScheme: finalColorScheme,
      scaffoldBackgroundColor: backgroundColor,

      // Text Theme
      textTheme: AppFonts.textTheme.apply(
        bodyColor: onBackgroundColor,
        displayColor: onBackgroundColor,
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: onBackgroundColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: onBackgroundColor,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: finalColorScheme.primary.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        surfaceTintColor: Colors.transparent,
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          shadowColor: finalColorScheme.primary.withValues(alpha: 0.4),
          backgroundColor: finalColorScheme.primary,
          foregroundColor: finalColorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),

      // Bottom Nav
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark
            ? AppColors.surfaceDark
            : AppColors.surfaceLight,
        selectedItemColor: finalColorScheme.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: GoogleFonts.nunito(fontWeight: FontWeight.bold),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: finalColorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        hintStyle: GoogleFonts.nunito(color: Colors.grey),
      ),

      // Search Bar
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(
          isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        ),
        elevation: WidgetStateProperty.all(4),
        shadowColor: WidgetStateProperty.all(
          finalColorScheme.shadow.withValues(alpha: 0.2),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        hintStyle: WidgetStateProperty.all(
          GoogleFonts.nunito(color: Colors.grey, fontSize: 16),
        ),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.nunito(color: onBackgroundColor, fontSize: 16),
        ),
      ),

      // Icon Theme
      iconTheme: IconThemeData(color: onBackgroundColor),
    );
  }

  // Deprecated static getters - keeping for compatibility until full refactor
  static ThemeData get lightTheme => getTheme(brightness: Brightness.light);
  static ThemeData get darkTheme => getTheme(brightness: Brightness.dark);
}
