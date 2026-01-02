import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/core/store/auth_store.dart';
import 'package:sophy/features/presentation/pages/author/view/author_page.dart';
import 'package:sophy/features/presentation/pages/home/view/home.dart';
import 'package:sophy/features/presentation/pages/library/view/library.dart';
import 'package:sophy/features/presentation/pages/login/view/login_page.dart';
import 'package:sophy/features/presentation/pages/player/view/player.dart';
import 'package:sophy/features/presentation/pages/profile/view/profile_page.dart';
import 'package:sophy/features/presentation/pages/search/view/search.dart';
import 'package:sophy/features/presentation/pages/settings/view/settings_page.dart';
import 'package:sophy/features/presentation/pages/splash/view/splash_page.dart';
import 'package:sophy/features/presentation/widgets/bottom_navigation_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  redirect: (context, state) {
    final authStore = getIt<AuthStore>();
    final isLoggedIn = authStore.isAuthenticated;
    final isLoggingIn = state.uri.toString() == '/login';
    final isSplash = state.uri.toString() == '/splash';

    // Allow splash screen to finish its logic
    if (isSplash) return null;

    // If not logged in and not going to login, redirect to login
    if (!isLoggedIn && !isLoggingIn) return '/login';

    // If logged in and going to login, redirect to home
    if (isLoggedIn && isLoggingIn) return '/home';

    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SplashPage(),
    ),
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
      builder: (context, state) => const LoginPage(),
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
    GoRoute(
      path: '/author',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AuthorPage(),
    ),
  ],
);
