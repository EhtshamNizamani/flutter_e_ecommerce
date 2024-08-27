import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double originalPrice;
  final double discountedPrice;
  final bool hasDiscount;

  const ProductCard({
    super.key,
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
        constraints: const BoxConstraints(
          maxHeight: 300, // Adjust based on your UI needs
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image with Hover Zoom Effect
                  Flexible(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
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
                  const SizedBox(height: 8),
                  // Product Title
                  Text(
                    widget.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  // Price
                  Row(
                    children: [
                      if (widget.hasDiscount)
                        Text(
                          '\$${widget.originalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      const SizedBox(width: 4),
                      Text(
                        '\$${widget.discountedPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '-${((widget.originalPrice - widget.discountedPrice) / widget.originalPrice * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(
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
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.shopping_cart),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
