import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quomodo/feature/home/controller/all_product_controller.dart';
import 'package:quomodo/feature/home/model/home_model.dart';
import 'package:quomodo/feature/home/view/product_details.dart';
import 'package:quomodo/feature/home/widget/product_card_widget.dart';
import 'package:quomodo/feature/home/widget/product_shimmer.dart';

class AllProductScreen extends StatelessWidget {
  AllProductScreen({super.key});
  final AllProductController controller = Get.put(AllProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF3E0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFC107),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'All Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.products.isEmpty) {
                    return const ProductGridShimmer();
                  }

                  if (controller.products.isEmpty) {
                    return const Center(child: Text('No products found'));
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount:
                        controller.products.length +
                        (controller.currentPage.value <
                                controller.lastPage.value
                            ? 1
                            : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.products.length) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.loadMoreProducts();
                        });
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              color: Color(0xFFFFC107),
                            ),
                          ),
                        );
                      }

                      final product = controller.products[index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ProductDetailScreen(),
                            arguments: product.slug,
                          );
                        },
                        child: ProductCard(
                          product: Product(
                            id: product.id,
                            name: product.name,
                            thumbImage: product.thumbImage,
                            price: product.price,
                            slug: product.slug,
                            offerPrice: product.offerPrice,
                            shortName: product.shortName,
                            qty: product.qty,
                            averageRating: product.averageRating,
                            totalSold: product.totalSold,
                            categoryId: product.categoryId,
                            activeVariants: [],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
