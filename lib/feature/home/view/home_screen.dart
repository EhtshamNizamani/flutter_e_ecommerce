import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/feature/home/widget/dashboard_widget.dart';
import 'package:flutter_e_commerce/util/responsive.dart';
import 'package:flutter_e_commerce/widgets/side_menu_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      endDrawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidget(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: DashboardWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
