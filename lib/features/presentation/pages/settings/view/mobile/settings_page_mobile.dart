import 'package:flutter/material.dart';
import 'package:sophy/l10n/app_localizations.dart';
import 'package:sophy/core/services/settings_service.dart';
import 'package:sophy/features/presentation/pages/settings/widgets/color_scheme_selector.dart';
import 'package:sophy/features/presentation/pages/settings/widgets/settings_section.dart';

class SettingsPageMobile extends StatelessWidget {
  const SettingsPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsService();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings_title)),
      body: AnimatedBuilder(
        animation: settings,
        builder: (context, child) {
          return ListView(
            children: [
              SettingsSection(
                title: l10n.settings_theme,
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.brightness_6),
                    title: Text(l10n.settings_theme_mode),
                    subtitle: Text(
                      settings.themeMode == ThemeMode.dark
                          ? l10n.settings_theme_dark
                          : l10n.settings_theme_light,
                    ),
                    value: settings.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      settings.toggleTheme();
                    },
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.settings_color_scheme,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        ColorSchemeSelector(
                          selectedColor: settings.seedColor,
                          onColorSelected: settings.setSeedColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SettingsSection(
                title: l10n.settings_language,
                children: [
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(l10n.settings_language),
                    subtitle: Text(
                      settings.locale.languageCode == 'en'
                          ? 'English'
                          : 'Русский',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      settings.toggleLocale();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SettingsSection(
                title: l10n.settings_privacy,
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.bug_report),
                    title: Text(l10n.settings_crash_reporting),
                    subtitle: Text(l10n.settings_crash_reporting_subtitle),
                    value: settings.isCrashReportingEnabled,
                    onChanged: (value) {
                      settings.setCrashReportingEnabled(value);
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
