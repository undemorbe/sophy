import 'package:flutter/material.dart';
import 'package:sophy/core/services/settings_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsService();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: AnimatedBuilder(
        animation: settings,
        builder: (context, child) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Theme'),
                subtitle: Text(settings.themeMode == ThemeMode.dark ? 'Dark' : 'Light'),
                trailing: Switch(
                  value: settings.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    settings.toggleTheme();
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                subtitle: Text(settings.locale.languageCode == 'en' ? 'English' : 'Russian'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  settings.toggleLocale();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
