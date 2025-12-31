import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Splash Screen')),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Login Screen')),
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Home Screen')),
      ),
    ),
  ],
);
