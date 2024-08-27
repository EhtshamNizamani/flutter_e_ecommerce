import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/util/responsive.dart';
import 'package:flutter_svg/svg.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      color: AppColors.black,
      padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 18),
      child: Column(
        crossAxisAlignment:
            isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          // Top section with logo and about text
          isDesktop ? FooterAboutDesktop() : FooterAboutUs(),
          SizedBox(height: 40.0),

          // Bottom section with columns for navigation
          isMobile ? ForMobile() : ForDesktop(),
          SizedBox(height: 40.0),

          // Footer Copyright Text
          Center(
            child: Text(
              'Copyright © 2024 Sports Wear Store',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class ForDesktop extends StatelessWidget {
  const ForDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shop Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shop at SpartaX',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Shop', style: TextStyle(color: Colors.grey)),
            Text('Top Deals', style: TextStyle(color: Colors.grey)),
            Text('My Account', style: TextStyle(color: Colors.grey)),
            Text('Return Policy', style: TextStyle(color: Colors.grey)),
          ],
        ),
        // About Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About SpartaX',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text('About', style: TextStyle(color: Colors.grey)),
            Text('SpartaX Tax', style: TextStyle(color: Colors.grey)),
            Text('Press Room', style: TextStyle(color: Colors.grey)),
            Text('Careers', style: TextStyle(color: Colors.grey)),
          ],
        ),
        // Contact Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get in Touch',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Bundesstraße 123, 456 Hamburg,\nGermany',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 5.0),
            Text('Call: +49-1234-56-7', style: TextStyle(color: Colors.grey)),
            Text('mail@example.com', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

class FooterAboutDesktop extends StatelessWidget {
  const FooterAboutDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              SvgPicture.asset('assets/images/logo.svg'),
              SizedBox(height: 20.0),
              // Social Media Icons (can be replaced with actual icons)
              Row(
                children: [
                  Icon(Icons.facebook, color: AppColors.white, size: 24.0),
                  SizedBox(width: 10.0),
                  Icon(Icons.youtube_searched_for,
                      color: AppColors.white, size: 24.0),
                  SizedBox(width: 10.0),
                  Icon(Icons.camera_alt, color: AppColors.white, size: 24.0),
                ],
              ),
            ],
          ),
          SizedBox(width: 46),
          // About Us
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ABOUT US',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Diam neque diam sed tincidunt lobortis facilisis massa eget scelerisque. '
                  'Egestas eu quam aenean odio urna faciliis integer tincidunt. Diam neque diam sed tincidunt lobortis facilisis massa eget scelerisque. '
                  'Egestas eu quam aenean odio urna faciliis integer tincidunt.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FooterAboutUs extends StatelessWidget {
  const FooterAboutUs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            SvgPicture.asset('assets/images/logo.svg'),
            SizedBox(height: 20.0),
            // Social Media Icons (can be replaced with actual icons)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.facebook, color: AppColors.white, size: 24.0),
                SizedBox(width: 10.0),
                Icon(Icons.youtube_searched_for,
                    color: AppColors.white, size: 24.0),
                SizedBox(width: 10.0),
                Icon(Icons.camera_alt, color: AppColors.white, size: 24.0),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        // About Us
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ABOUT US',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.center,
              'Diam neque diam sed tincidunt lobortis facilisis massa eget scelerisque. '
              'Egestas eu quam aenean odio urna faciliis integer tincidunt. Diam neque diam sed tincidunt lobortis facilisis massa eget scelerisque. '
              'Egestas eu quam aenean odio urna faciliis integer tincidunt.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

class ForMobile extends StatelessWidget {
  const ForMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Shop Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Shop at SpartaX',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Shop', style: TextStyle(color: Colors.grey)),
            Text('Top Deals', style: TextStyle(color: Colors.grey)),
            Text('My Account', style: TextStyle(color: Colors.grey)),
            Text('Return Policy', style: TextStyle(color: Colors.grey)),
          ],
        ),
        SizedBox(height: 16),

        // About Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'About SpartaX',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text('About', style: TextStyle(color: Colors.grey)),
            Text('SpartaX Tax', style: TextStyle(color: Colors.grey)),
            Text('Press Room', style: TextStyle(color: Colors.grey)),
            Text('Careers', style: TextStyle(color: Colors.grey)),
          ],
        ),
        SizedBox(height: 16),
        // Contact Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Get in Touch',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.center,
              'Bundesstraße 123, 456 Hamburg,\nGermany',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 5.0),
            Text('Call: +49-1234-56-7', style: TextStyle(color: Colors.grey)),
            Text('mail@example.com', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
