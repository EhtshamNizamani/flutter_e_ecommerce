import 'package:flutter_e_commerce/common/custom_text.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/util/responsive.dart';
import 'package:flutter_e_commerce/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  Color contactColor = AppColors.white;
  Color homeColor = AppColors.white;
  Color aboutColor = AppColors.white;

  void _incrementExit(name) {
    setState(() {
      contactColor = AppColors.white;
      aboutColor = AppColors.white;
      homeColor = AppColors.white;
    });
  }

  void _updateLocation(name) {
    switch (name) {
      case 'About':
        aboutColor = AppColors.primary;
      case 'Contact':
        contactColor = AppColors.primary;
      case 'Home':
        homeColor = AppColors.primary;
        break;
      default:
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/images/logo.svg',
          ),
          !Responsive.isDesktop(context)
              ? SizedBox.shrink()
              : Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 300,
                      ),
                      Row(
                        children: [
                          MouseRegion(
                            onHover: (_) => _updateLocation('Home'),
                            onExit: (_) => _incrementExit('Home'),
                            child: InkWell(
                              hoverColor: AppColors.backgroundColor,
                              onTap: () {},
                              child: CustomText(
                                text: "Home",
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Responsive.isDesktop(context)
                                        ? homeColor
                                        : null),
                              ),
                            ),
                          ),
                          SizedBox(width: 26),
                          MouseRegion(
                            onHover: (_) => _updateLocation('About'),
                            onExit: (_) => _incrementExit('About'),
                            child: InkWell(
                              hoverColor: AppColors.backgroundColor,
                              onTap: () {},
                              child: CustomText(
                                text: "About us",
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Responsive.isDesktop(context)
                                        ? aboutColor
                                        : null),
                              ),
                            ),
                          ),
                          SizedBox(width: 26),
                          MouseRegion(
                            onHover: (_) => _updateLocation('Contact'),
                            onExit: (_) => _incrementExit('Contact'),
                            child: InkWell(
                              hoverColor: AppColors.backgroundColor,
                              onTap: () {},
                              child: CustomText(
                                text: "Contact us",
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Responsive.isDesktop(context)
                                        ? contactColor
                                        : null),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 35),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 300, // Max width is 300 pixels
                                    minWidth: 100,
                                    maxHeight: 50),
                                child: CustomTextField(
                                    fillColor: Colors.transparent,
                                    borderColor: AppColors.white,
                                    controller: TextEditingController(),
                                    hintText: 'Search',
                                    styleColor: AppColors.white,
                                    suffixIcon: 'assets/images/search.svg'),
                              ),
                            ),
                            SizedBox(width: 30),
                            CustomText(
                              text: "\$0.00",
                              textStyle: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.shopping_cart_outlined,
                                color: AppColors.white)
                          ],
                        ),
                      ),
                      SizedBox(width: 200),
                    ],
                  ),
                ),
          if (!Responsive.isDesktop(context))
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () => Scaffold.of(context).openEndDrawer(),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
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
