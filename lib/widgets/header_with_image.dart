import 'package:flutter_e_commerce/common/primary_button.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/util/responsive.dart';
import 'package:flutter_e_commerce/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class HeaderWithImage extends StatelessWidget {
  const HeaderWithImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTrue = MediaQuery.of(context).size.width < 770;

    return Stack(
      children: [
        // Background image
        Image.asset(
          'assets/images/background_image.jpg',
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 110, // Adjust this to control vertical positioning
          left: 20,
          child: Container(
            width: 90,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(6)),
          ),
        ),
        // Overlayed content (text, buttons) limited to the left side
        Positioned(
          top: 140, // Adjust this to control vertical positioning
          left: 20,
          bottom: 0, // Keep content aligned to the left side
          child: Container(
            width: isTrue
                ? MediaQuery.of(context).size.width * 1
                : MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's Level Up Your Game",
                  style: TextStyle(
                    fontSize: Responsive.isDesktop(context) ? 75 : 60,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Nam natoque in massa bibendum lacus, et arcu cursus nisl rutrum at tincidunt in sit in massa adipiscing lorem fusce.",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 30),
                PrimaryButton(
                  width: 156,
                  height: 46,
                  onTap: () {},
                  text: "Shop Now",
                  fontSize: 14,
                  borderRadius: 40,
                  textColor: AppColors.black,
                  buttonColor: AppColors.white,
                ),
              ],
            ),
          ),
        ),
        HeaderWidget(),
      ],
    );
  }
}
