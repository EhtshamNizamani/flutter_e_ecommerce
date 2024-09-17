import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/common/custom_text.dart';
import 'package:flutter_e_commerce/common/primary_button.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/util/responsive.dart';
import 'package:flutter_e_commerce/feature/shared_widget/custom_textfield.dart';

class SubscribeWidget extends StatelessWidget {
  const SubscribeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90.0, horizontal: 65),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Main Heading
            CustomText(
              text: 'Be The First To Know',
              textStyle: TextStyle(
                fontSize: Responsive.isMobile(context) ? 28 : 48.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),

            // Subtitle Text
            CustomText(
              text:
                  'Lectus amet scelerisque fusce est venenatis, eget enim dolor amet vitae pharetra.',
              textStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),

            // Email Input and Subscribe Button
            Responsive.isMobile(context)
                ? Column(
                    children: [
                      // Email Input Field
                      Container(
                        width: double.infinity,
                        height: 45,
                        child: CustomTextField(
                          borderColor: AppColors.primary,
                          fillColor: Colors.white,
                          labelText: 'Email Address',
                          controller: TextEditingController(),
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      // Subscribe Button
                      PrimaryButton(
                        onTap: () {
                          // Implement your subscribe logic here
                        },
                        buttonColor: AppColors.primary,
                        text: 'SUBSCRIBE',
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Email Input Field
                      Container(
                        width: 300.0,
                        height: 45,
                        child: CustomTextField(
                          borderColor: AppColors.primary,
                          fillColor: Colors.white,
                          labelText: 'Email Address',
                          controller: TextEditingController(),
                        ),
                      ),
                      const SizedBox(width: 10.0),

                      // Subscribe Button
                      PrimaryButton(
                        width: 156,
                        borderRadius: 50,
                        onTap: () {
                          // Implement your subscribe logic here
                        },
                        buttonColor: AppColors.primary,
                        text: 'SUBSCRIBE',
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
