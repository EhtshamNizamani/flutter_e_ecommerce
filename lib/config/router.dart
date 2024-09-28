import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/config/http/cookie_manager.dart';
import 'package:flutter_e_commerce/config/routes.dart';
import 'package:flutter_e_commerce/feature/auth/view/login_page.dart';
import 'package:flutter_e_commerce/feature/auth/view/register_page.dart';
import 'package:flutter_e_commerce/feature/home/view/home_screen.dart';
import 'package:flutter_e_commerce/feature/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter gotRouter() {
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _fadeTransitionPageBuilder(
          context,
          state.pageKey,
          const HomeScreen(),
        ),
        routes: <RouteBase>[
          GoRoute(
            path: profile,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                _fadeTransitionPageBuilder(
              context,
              state.pageKey,
              const ProfileScreen(),
            ),
          ),
          GoRoute(
            path: register,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                _fadeTransitionPageBuilder(
              context,
              state.pageKey,
              const RegistrationPage(),
            ),
          ),
          GoRoute(
            path: login,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                _fadeTransitionPageBuilder(
              context,
              state.pageKey,
              LoginPage(),
            ),
          ),
        ],
      ),
    ],
    // Redirect logic
    redirect: (context, state) {
      final String? isAuthenticated =
          CookieManager.retrieveCookie('accessToken');
      // Use state.location or state.uri.toString() instead of GoRouter.of(context)
      final currentLocation = state.uri.toString();

      // If authenticated and tries to access login or register, redirect to home
      if (isAuthenticated != null &&
          (currentLocation == '/login' || currentLocation == '/register')) {
        return '/';
      }

      // If not authenticated and tries to access home, redirect to login
      if (isAuthenticated == null && currentLocation == '/') {
        return '/login';
      }

      return null; // No redirection
    },
  );
}

Page _fadeTransitionPageBuilder(
    BuildContext context, LocalKey key, Widget child) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 100), // Fast transition
  );
}
