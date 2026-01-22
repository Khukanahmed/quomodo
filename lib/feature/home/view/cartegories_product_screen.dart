import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quomodo/feature/home/controller/categories_controller.dart';
import 'package:quomodo/feature/home/model/home_model.dart';
import 'package:quomodo/feature/home/view/product_details.dart';
import 'package:quomodo/feature/home/widget/product_card_widget.dart';
import 'package:quomodo/feature/home/widget/product_shimmer.dart';

class CartegoriesProductScreen extends StatelessWidget {
  final String? category;
  CartegoriesProductScreen({super.key, this.category});
  final CategoriesController controller = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF3E0),
      //appBar: AppBar(title: Text(category ?? 'Category Products')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      category ?? 'Category Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Search Bar
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search products',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
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
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final productCategory = controller.products[index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ProductDetailScreen(),
                            arguments: productCategory.slug,
                          );
                        },
                        child: ProductCard(
                          product: Product(
                            id: index,
                            name: productCategory.name,
                            thumbImage: productCategory.thumbImage,
                            price: productCategory.price,
                            slug: productCategory.slug,
                            offerPrice: productCategory.offerPrice,
                            shortName: productCategory.name,
                            qty: 10,
                            averageRating: productCategory.averageRating,
                            totalSold: productCategory.totalSold,
                            categoryId: 1,
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
