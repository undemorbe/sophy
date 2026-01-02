import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/features/presentation/pages/home/view/home.dart';
import 'package:sophy/features/presentation/pages/library/view/library.dart';
import 'package:sophy/features/presentation/pages/player/view/player.dart';
import 'package:sophy/features/presentation/pages/profile/view/profile_page.dart';
import 'package:sophy/features/presentation/pages/search/view/search.dart';
import 'package:sophy/features/presentation/pages/settings/view/settings_page.dart';
import 'package:sophy/features/presentation/widgets/bottom_navigation_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: MyBottomNavigationBar(
            navigationShell: navigationShell,
          ),
        );
      },
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', builder: (context, state) => HomeViewPage()),
          ],
        ),
        // Search Branch (Placeholder)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchPage(),
            ),
          ],
        ),
        // Player Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/player',
              builder: (context, state) => const PlayerPage(),
            ),
          ],
        ),
        // Library Branch (Placeholder)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/library',
              builder: (context, state) => const LibraryPage(),
            ),
          ],
        ),
      ],
    ),
    // Other routes outside the shell
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('Login Screen'))),
    ),
    GoRoute(
      path: '/profile',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
