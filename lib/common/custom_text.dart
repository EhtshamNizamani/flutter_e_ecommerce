import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final bool? isUnderline;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  const CustomText({
    super.key,
    this.textStyle,
    this.maxLines,
    this.isUnderline,
    this.textAlign,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines ?? 4,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      text ?? '',
      style: textStyle,
    );
  }
}
