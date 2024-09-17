import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/config/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/feature/auth/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'feature/home/controller/home_provider.dart';

void main() {
  final GoRouter _router = gotRouter();
  runApp(MyApp(router: _router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => HomeProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => AuthProvider(),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerDelegate: router.routerDelegate,
                routeInformationParser: router.routeInformationParser,
                routeInformationProvider: router.routeInformationProvider,
                theme: ThemeData(
                  scaffoldBackgroundColor: AppColors.backgroundColor,
                  brightness: Brightness.light,
                ),
                title: 'Fitness Dashboard',
              );
            }));
  }
}
