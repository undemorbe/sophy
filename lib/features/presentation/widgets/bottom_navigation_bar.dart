import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/l10n/app_localizations.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navigationShell.currentIndex,
      onTap: (index) {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppLocalizations.of(context)!.bottom_navigation_bar_homepage,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: AppLocalizations.of(context)!.bottom_navigation_bar_search,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.radio),
          label: AppLocalizations.of(
            context,
          )!.bottom_navigation_bar_now_playing,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          label: AppLocalizations.of(context)!.bottom_navigation_bar_playlists,
        ),
      ],
    );
  }
}
