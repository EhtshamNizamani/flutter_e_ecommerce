import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/config/rotues.dart';
import 'package:flutter_e_commerce/feature/auth/login_page.dart';
import 'package:flutter_e_commerce/feature/auth/register_page.dart';
import 'package:flutter_e_commerce/feature/home/view/home_screen.dart';
import 'package:flutter_e_commerce/feature/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter gotRouter() {
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: profile,
            builder: (BuildContext context, GoRouterState state) {
              return const ProfileScreen();
            },
          ),
          GoRoute(
            path: register,
            builder: (BuildContext context, GoRouterState state) {
              return const RegistrationPage();
            },
          ),
          GoRoute(
            path: login,
            builder: (BuildContext context, GoRouterState state) {
              return const LoginPage();
            },
          ),
        ],
      ),
    ],
  );
}
