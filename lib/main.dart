import 'package:flutter/material.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const SophyApp());
}

class SophyApp extends StatelessWidget {
  const SophyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sophy Messenger',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(
          child: Text('Welcome to Sophy'),
        ),
      ),
    );
  }
}
