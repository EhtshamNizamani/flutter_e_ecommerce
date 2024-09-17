import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPasswordField extends StatelessWidget {
  final String labelText;
  final bool isOpen;
  final Icon? prefixIcon;
  final bool isReadOnly;
  final VoidCallback onTap;
  final bool isChangePassword;
  final TextEditingController controller;

  final Function(dynamic)? validator;
  const CustomPasswordField(
      {required this.isOpen,
      this.isChangePassword = false,
      required this.labelText,
      required this.onTap,
      this.isReadOnly = false,
      required this.controller,
      this.prefixIcon,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      cursorColor: AppColors.black,
      controller: controller,
      validator: (value) {
        // Call the validator function (if it's not null)
        if (validator != null) {
          final String? msg = validator!(value);
          if (msg != null ? msg.length > 45 : false) {}
          return validator!(value);
        }
        return null;
      },
      obscureText: !isOpen,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        fillColor: theme.colorScheme.background,
        filled: true,
        errorMaxLines: 4,
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        labelStyle: theme.textTheme.titleMedium!.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        prefixIcon: prefixIcon,

        // suffixIcon: Padding(
        //   padding: EdgeInsets.all(isChangePassword ? 14.dg : 10.dg),
        //   child: GestureDetector(
        //     onTap: onTap,
        //     child: isChangePassword
        //         ? CustomText(
        //             text: ProfileConstantText.changePassword,
        //             textStyle: theme.textTheme.titleMedium?.copyWith(
        //               color: theme.colorScheme.primary,
        //             ))
        //         : SvgPicture.asset(
        //             'assets/svgs/${isOpen ? 'eye_opened' : 'eye_closed'}.svg',
        //           ),
        //   ),
        // ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.primaryColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.primaryColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.red, width: 1),
        ),
        errorStyle: theme.textTheme.titleMedium!.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: AppColors.red,
        ),
      ),
      style: theme.textTheme.titleMedium!.copyWith(
        fontSize: 12,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
