import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/common/custom_text.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/config/rotues.dart';
import 'package:flutter_e_commerce/feature/home/controller/home_provider.dart';
import 'package:flutter_e_commerce/util/responsive.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'custom_textfield.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget(
      {super.key,
      this.fontColor = AppColors.white,
      this.mainColor = AppColors.white,
      this.bgColor});
  final Color fontColor;
  final Color mainColor;
  final Color? bgColor;
  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().setColors(widget.fontColor);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Container(
        padding: const EdgeInsets.all(18.0),
        color: widget.bgColor == null ? Colors.transparent : widget.bgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              widget.bgColor == null
                  ? 'assets/images/logo.svg'
                  : 'assets/images/b-logo.svg',
            ),
            !Responsive.isDesktop(context)
                ? const SizedBox.shrink()
                : Expanded(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 300,
                        ),
                        Row(
                          children: [
                            MouseRegion(
                              onHover: (_) => provider.updateLocation('Home'),
                              onExit: (_) => provider.incrementExit('Home'),
                              child: InkWell(
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  provider.changeTab(0);
                                },
                                child: CustomText(
                                  text: "HOME",
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Responsive.isDesktop(context)
                                          ? provider.homeColor
                                          : null),
                                ),
                              ),
                            ),
                            const SizedBox(width: 26),
                            MouseRegion(
                              onHover: (_) =>
                                  provider.updateLocation('SHOP ALL'),
                              onExit: (_) => provider.incrementExit('SHOP ALL'),
                              child: InkWell(
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  provider.changeTab(1);
                                },
                                child: CustomText(
                                  text: "SHOP ALL",
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Responsive.isDesktop(context)
                                          ? provider.shopAllColor
                                          : null),
                                ),
                              ),
                            ),
                            const SizedBox(width: 26),
                            MouseRegion(
                              onHover: (_) =>
                                  provider.updateLocation('Contact'),
                              onExit: (_) => provider.incrementExit('Contact'),
                              child: InkWell(
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  provider.changeTab(2);
                                },
                                child: CustomText(
                                  text: "CONTACT US",
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Responsive.isDesktop(context)
                                          ? provider.contactColor
                                          : null),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 35),
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: 300, // Max width is 300 pixels
                                      minWidth: 100,
                                      maxHeight: 50),
                                  child: CustomTextField(
                                      fillColor: Colors.transparent,
                                      borderColor: widget.mainColor,
                                      controller: TextEditingController(),
                                      hintText: 'Search',
                                      styleColor: widget.mainColor,
                                      suffixIcon: 'assets/images/search.svg'),
                                ),
                              ),
                              const SizedBox(width: 30),
                              CustomText(
                                text: "\$0.00",
                                textStyle: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: widget.mainColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 8),
                              MouseRegion(
                                onHover: (_) => provider.updateLocation('Cart'),
                                onExit: (_) => provider.incrementExit('Cart'),
                                child: Icon(Icons.shopping_cart_outlined,
                                    color: provider.cartColor),
                              ),
                              const SizedBox(width: 8),
                              MouseRegion(
                                  onHover: (_) =>
                                      provider.updateLocation('Person'),
                                  onExit: (_) =>
                                      provider.incrementExit('Person'),
                                  child: InkWell(
                                    onTap: () {
                                      context.go("/$register");
                                    },
                                    child: Icon(Icons.person,
                                        color: provider.personColor),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(width: 200),
                      ],
                    ),
                  ),
            if (!Responsive.isDesktop(context))
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.menu,
                      color: AppColors.primary,
                      size: 25,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}

// class CustomTextfield extends StatelessWidget {
//   const CustomTextfield({
//     this.isIcon = false,
//     required this.hint,
//     super.key,
//   });

//   final String hint;
//   final bool isIcon;

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       style: GoogleFonts.poppins(color: AppAppColors.grey),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: GoogleFonts.poppins(color: AppColors.grey),
//         suffixIcon: isIcon
//             ? Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: SvgPicture.asset(
//                   'assets/images/search.svg',
//                   color: AppColors.primary,
//                 ),
//               )
//             : null,
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: AppColors.primary,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: AppColors.primary,
//           ),
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//       onChanged: (value) {
//         // Handle changes here
//         print('Text changed: $value');
//       },
//     );
//   }
// }
