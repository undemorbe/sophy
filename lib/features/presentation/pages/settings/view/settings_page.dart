import 'package:flutter/material.dart';
import 'package:sophy/core/constants/ui_constants.dart';
import 'package:sophy/features/presentation/pages/settings/view/laptop/settings_page_laptop.dart';
import 'package:sophy/features/presentation/pages/settings/view/mobile/settings_page_mobile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kDesktopBreakpoint) {
          return const SettingsPageLaptop();
        } else {
          return const SettingsPageMobile();
        }
      },
    );
  }
}
