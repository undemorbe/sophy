import 'package:flutter/material.dart';
import 'package:sophy/core/constants/ui_constants.dart';
import 'package:sophy/features/presentation/pages/player/view/laptop/player_page_laptop.dart';
import 'package:sophy/features/presentation/pages/player/view/mobile/player_page_mobile.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kDesktopBreakpoint) {
          return const PlayerPageLaptop();
        } else {
          return const PlayerPageMobile();
        }
      },
    );
  }
}
