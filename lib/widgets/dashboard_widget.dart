import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/widgets/footer_widget.dart';
import 'package:flutter_e_commerce/widgets/header_with_image.dart';
import 'package:flutter_e_commerce/widgets/subscribe_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderWithImage(),
          SizedBox(height: 16),
          ProductViewSection(),
          SizedBox(height: 35),
          SubscribeWidget(),
          FooterWidget(),
        ],
      ),
    );
  }
}

class ProductViewSection extends StatelessWidget {
  const ProductViewSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
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
            return ProductCard(
                hasDiscount: true,
                imageUrl: 'assets/images/shoe.png',
                title: 'Consequat running shoes',
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

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double originalPrice;
  final double discountedPrice;
  final bool hasDiscount;

  ProductCard({
    required this.imageUrl,
    required this.title,
    required this.originalPrice,
    required this.discountedPrice,
    this.hasDiscount = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  void _onHover(bool hovering) {
    setState(() {
      _isHovered = hovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: Container(
        color: AppColors.imgBG,
        constraints: BoxConstraints(
          maxHeight: 300, // Adjust based on your UI needs
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image with Hover Zoom Effect
                  Flexible(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      transform: _isHovered
                          ? (Matrix4.identity()..scale(1.05))
                          : Matrix4.identity(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ClipRRect(
                          child: Image.asset(
                            widget.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Product Title
                  Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  // Price
                  Row(
                    children: [
                      if (widget.hasDiscount)
                        Text(
                          '\$${widget.originalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      SizedBox(width: 4),
                      Text(
                        '\$${widget.discountedPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Discount Tag
            if (widget.hasDiscount)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '-${((widget.originalPrice - widget.discountedPrice) / widget.originalPrice * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            // Cart Icon (Visible on Hover or Always on Mobile)
            if (!kIsWeb || _isHovered)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    // Add to cart functionality
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(Icons.shopping_cart),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
