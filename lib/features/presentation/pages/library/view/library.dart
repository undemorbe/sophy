import 'package:flutter/material.dart';
import 'package:sophy/core/constants/ui_constants.dart';
import 'package:sophy/features/presentation/pages/library/view/laptop/library_page_laptop.dart';
import 'package:sophy/features/presentation/pages/library/view/mobile/library_page_mobile.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kDesktopBreakpoint) {
          return const LibraryPageLaptop();
        } else {
          return const LibraryPageMobile();
        }
      },
    );
  }
}
