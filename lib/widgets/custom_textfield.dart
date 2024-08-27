import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final int maxLine;
  final Color? fillColor;
  final Color? borderColor;
  final Function(String? text)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final Function(dynamic)? validator;
  final int? maxLength;
  final Color? styleColor;
  final bool isReadOnly;
  final String? suffixIcon;
  final TextEditingController controller;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.suffixIcon,
      this.keyboardType,
      this.validator,
      this.styleColor,
      this.fillColor,
      this.onFieldSubmitted,
      this.borderColor,
      this.isReadOnly = false,
      this.maxLine = 1,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      readOnly: isReadOnly,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.name,

      validator: (value) {
        // Call the validator function (if it's not null)
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      maxLines: maxLine,
      maxLength: maxLength,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? Container(
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                child: SvgPicture.asset(
                  suffixIcon!,
                  color: AppColors.white,
                ),
              )
            : null,
        hintText: hintText,
        hintStyle: theme.textTheme.titleMedium!.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? theme.primaryColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? theme.primaryColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: fillColor ?? AppColors.backgroundColor,
        errorStyle: theme.textTheme.titleMedium!.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.red,
        ),
      ),

      style: theme.textTheme.titleMedium!.copyWith(
        fontSize: 12,
        color: styleColor ?? AppColors.grey,
        fontWeight: FontWeight.w400,
      ),
      cursorColor: AppColors.grey,
      // Other properties as needed
    );
  }
}
