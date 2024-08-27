import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductViewSection extends StatelessWidget {
  const ProductViewSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(context),
            crossAxisSpacing: 24,
            mainAxisSpacing: 16,
            childAspectRatio:
                0.75, // Adjust this to control the height of the items
          ),
          itemBuilder: (context, index) {
            return const ProductCard(
                hasDiscount: true,
                imageUrl: 'assets/images/shoe.png',
                title: 'Cons running shoes',
                originalPrice: 311,
                discountedPrice: 300);
          }),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1200) {
      // Desktop
      return 4;
    } else if (screenWidth > 800) {
      // Tablet
      return 3;
    } else if (screenWidth > 400) {
      // Regular Mobile
      return 2;
    } else {
      // Small Mobile
      return 1;
    }
  }
}
