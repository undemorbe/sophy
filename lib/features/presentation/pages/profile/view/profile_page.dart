import 'package:flutter/material.dart';
import 'package:sophy/core/constants/ui_constants.dart';
import 'package:sophy/features/presentation/pages/profile/view/laptop/profile_page_laptop.dart';
import 'package:sophy/features/presentation/pages/profile/view/mobile/profile_page_mobile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kDesktopBreakpoint) {
          return const ProfilePageLaptop();
        } else {
          return const ProfilePageMobile();
        }
      },
    );
  }
}
