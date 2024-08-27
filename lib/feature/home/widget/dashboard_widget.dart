import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/common/custom_text.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/feature/home/controller/home_provider.dart';
import 'package:flutter_e_commerce/feature/home/widget/all_product_widget.dart';
import 'package:flutter_e_commerce/feature/home/widget/product_card.dart';
import 'package:flutter_e_commerce/feature/home/widget/subscribe_widget.dart';
import 'package:flutter_e_commerce/widgets/footer_widget.dart';
import 'package:flutter_e_commerce/widgets/header_widget.dart';
import 'package:flutter_e_commerce/widgets/header_with_image.dart';
import 'package:provider/provider.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<HomeProvider>(builder: (context, provider, child) {
        final selectedTab = provider.selectedTab;
        return Column(
          children: [
            selectedTab == 0
                ? HeaderWithImage()
                : HeaderWidget(
                    fontColor: AppColors.grey,
                    mainColor: AppColors.primary,
                    bgColor: AppColors.white,
                  ),
            SizedBox(height: 16),
            if (selectedTab == 0)
              ProductViewSection() // Default Tab
            else if (selectedTab == 1)
              MenProduct()
            else if (selectedTab == 2)
              CustomText(text: "This is women category"),
            SizedBox(height: 35),
            SubscribeWidget(),
            FooterWidget(),
          ],
        );
      }),
    );
  }
}

class MenProduct extends StatelessWidget {
  const MenProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(context),
            crossAxisSpacing: 24,
            mainAxisSpacing: 16,
            childAspectRatio:
                0.75, // Adjust this to control the height of the items
          ),
          itemBuilder: (context, index) {
            return ProductCard(
                hasDiscount: true,
                imageUrl: 'assets/images/helmet.jpg',
                title: 'Purus elit helmet',
                originalPrice: 231,
                discountedPrice: 222);
          }),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1200) {
      // Desktop
      return 4;
    } else if (screenWidth > 800) {
      // Tablet
      return 3;
    } else if (screenWidth > 400) {
      // Regular Mobile
      return 2;
    } else {
      // Small Mobile
      return 1;
    }
  }
}
