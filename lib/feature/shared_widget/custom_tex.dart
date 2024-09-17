import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final String? text;
  final bool? isUnderline;
  final int? maxLines;
  final double? letterSpacing;
  final TextAlign? textAlign;
  const CustomTextWidget({
    super.key,
    this.maxLines,
    this.isUnderline,
    this.letterSpacing,
    this.textAlign,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines ?? 4,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      text ?? '',
      style: GoogleFonts.poppins(
          decoration: isUnderline != null ? TextDecoration.underline : null,
          letterSpacing: letterSpacing ?? 0.5,
          fontSize: fontSize ?? 12,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? AppColors.black),
    );
  }
}
