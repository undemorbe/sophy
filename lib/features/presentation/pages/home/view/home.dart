import 'package:flutter/material.dart';
import 'package:sophy/core/constants/ui_constants.dart';
import 'package:sophy/features/presentation/pages/home/view/laptop/home_view_laptop.dart';
import 'package:sophy/features/presentation/pages/home/view/mobile/home_view_mobile.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > kDesktopBreakpoint) {
          return const HomeViewLaptop();
        } else {
          return const HomeViewMobile();
        }
      },
    );
  }
}
