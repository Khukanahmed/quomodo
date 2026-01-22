import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quomodo/feature/home/controller/home_controller.dart';
import 'package:quomodo/feature/home/model/home_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({super.key, required this.product});
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      'https://mamunuiux.com/flutter_task/${product.thumbImage}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Discount Badge
                if (product.hasDiscount)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '-${product.discountPercentage}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                // Favorite Button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Obx(
                    () => GestureDetector(
                      onTap: () => controller.toggleFavorite(product.id),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          controller.isFavorite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.isFavorite(product.id)
                              ? Colors.red
                              : Colors.grey[400],
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product Details
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Rating
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < product.ratingValue.floor()
                              ? Icons.star
                              : Icons.star_border,
                          size: 12,
                          color: Colors.amber,
                        );
                      }),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '(${product.totalSold})',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),

                  // Product Name
                  Expanded(
                    child: Text(
                      product.shortName,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4),

                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${product.displayPrice.toInt()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: product.hasDiscount
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        SizedBox(width: 4),
                        Text(
                          '\$${product.price.toInt()}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
