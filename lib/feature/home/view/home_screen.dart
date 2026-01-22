import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quomodo/feature/home/controller/home_controller.dart';
import 'package:quomodo/feature/home/view/product_details.dart';
import 'package:quomodo/feature/home/widget/category_item_widget.dart';
import 'package:quomodo/feature/home/widget/category_shimmer.dart';
import 'package:quomodo/feature/home/widget/product_card_widget.dart';
import 'package:quomodo/feature/home/widget/product_shimmer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Categories title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: CategoryShimmer(),
                      ),

                      SizedBox(height: 32),

                      // New Arrivals title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'New Arrivals',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ProductGridShimmer(),
                      ),
                    ],
                  ),
                );
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 60, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        controller.errorMessage.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => controller.loadData(),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categories Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.toggleSeeAll();
                            },
                            child: Obx(
                              () => Text(
                                controller.showAllCategories.value
                                    ? 'Show less'
                                    : 'See all',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Obx(
                        () => Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: controller.visibleCategories.map((
                            category,
                          ) {
                            return GestureDetector(
                              onTap: () {
                                print('Selected category: ${category.name}');
                              },
                              child: CategoryItem(category: category),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    SizedBox(height: 24),

                    // New Arrivals Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'New Arrivals',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.tune, color: Colors.grey[600]),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Products Grid
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => ProductDetailScreen(),
                                arguments: controller.products[index].slug,
                              );
                            },
                            child: ProductCard(
                              product: controller.products[index],
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
