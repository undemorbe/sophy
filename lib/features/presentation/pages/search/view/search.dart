import 'package:flutter/material.dart';
import 'package:sophy/core/constants/ui_constants.dart';
import 'package:sophy/features/presentation/pages/search/view/laptop/search_page_laptop.dart';
import 'package:sophy/features/presentation/pages/search/view/mobile/search_page_mobile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kDesktopBreakpoint) {
          return const SearchPageLaptop();
        } else {
          return const SearchPageMobile();
        }
      },
    );
  }
}
