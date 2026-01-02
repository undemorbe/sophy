import 'package:flutter/material.dart';
import 'package:sophy/core/constants/ui_constants.dart';
import 'package:sophy/features/presentation/pages/login/view/laptop/login_page_laptop.dart';
import 'package:sophy/features/presentation/pages/login/view/mobile/login_page_mobile.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kDesktopBreakpoint) {
          return const LoginPageLaptop();
        } else {
          return const LoginPageMobile();
        }
      },
    );
  }
}
