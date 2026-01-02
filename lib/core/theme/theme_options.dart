import 'package:flutter/material.dart';
import 'package:sophy/core/theme/colors.dart';

class ThemeOption {
  final String name;
  final Color color;

  const ThemeOption({required this.name, required this.color});
}

class AppThemeOptions {
  static const List<ThemeOption> options = [
    ThemeOption(name: 'Default', color: AppColors.pastelPink),
    ThemeOption(name: 'Ocean', color: Colors.blue),
    ThemeOption(name: 'Forest', color: Colors.green),
    ThemeOption(name: 'Sunset', color: Colors.orange),
    ThemeOption(name: 'Lavender', color: Colors.purple),
    ThemeOption(name: 'Crimson', color: Colors.red),
    ThemeOption(name: 'Teal', color: Colors.teal),
  ];
  
  static ThemeOption getOptionByColor(Color color) {
    return options.firstWhere(
      (element) => element.color.value == color.value,
      orElse: () => options.first,
    );
  }
}
