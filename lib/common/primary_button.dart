import 'package:flutter_e_commerce/common/custom_text.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final Color? textColor;
  final VoidCallback? onTap;
  final Color buttonColor;
  final bool isLoading;
  final bool isBorder;
  final double fontSize;
  final double? width;
  final String? isIcon;
  final double? height;
  final FontWeight? fontWeight;
  final double? borderRadius;

  const PrimaryButton({
    super.key,
    this.textColor,
    this.isBorder = false,
    this.borderRadius,
    this.fontWeight,
    this.width,
    this.height,
    this.isIcon,
    this.fontSize = 13,
    this.isLoading = false,
    this.buttonColor = AppColors.primary,
    required this.text,
    required this.onTap,
  });

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: widget.width ?? double.infinity,
          height: widget.height ?? 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.isBorder
                ? theme.colorScheme.background
                : _isHovering
                    ? widget.buttonColor.withOpacity(0.9)
                    : widget.buttonColor,
            border: widget.isBorder
                ? Border.all(
                    width: 1,
                    color: widget.textColor ?? widget.buttonColor,
                  )
                : null,
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ]
                : [],
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          ),
          child: widget.isLoading
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: theme.colorScheme.background,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.isIcon != null
                        ? SvgPicture.asset(
                            widget.isIcon!,
                            color: theme.colorScheme.background,
                            width: 24,
                            height: 25,
                          )
                        : const SizedBox.shrink(),
                    SizedBox(width: 6),
                    CustomText(
                      text: widget.text,
                      textStyle: GoogleFonts.montserrat(
                        color: widget.textColor ?? theme.colorScheme.background,
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight ?? FontWeight.w500,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void _onHover(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });
  }
}
