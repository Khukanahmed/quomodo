import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quomodo/core/network_caller/endpoints.dart';
import 'package:quomodo/feature/home/model/category_model.dart';

class CategoriesController extends GetxController {
  final isLoading = true.obs;
  final categoryId = 0.obs;
  final searchQuery = ''.obs;

  final categoryResponse = Rxn<CategoryProductResponse>();
  final allProducts = <CategoryProduct>[].obs;
  final products = <CategoryProduct>[].obs;
  final wishlistIds = <int>[].obs;

  @override
  void onInit() {
    super.onInit();

    categoryId.value = Get.arguments ?? 0;

    if (kDebugMode) {
      print('CategoriesController initialized with ID: ${categoryId.value}');
    }

    fetchCategoryProducts(categoryId.value);
  }

  Future<void> fetchCategoryProducts(int id) async {
    try {
      isLoading.value = true;

      final url = Uri.parse('${Urls.baseUrl}/product-by-category/$id');
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );
      if (kDebugMode) {
        print('Fetching products for category ID: ${response.body}');
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response Body: ${response.body}');
        }
        final decoded = jsonDecode(response.body);

        final responseModel = CategoryProductResponse.fromJson(decoded);

        categoryResponse.value = responseModel;
        allProducts.value = responseModel.products;
        products.value = responseModel.products;
      } else {
        Get.snackbar('Error', 'Failed to load products');
      }
    } catch (e) {
      if (kDebugMode) {
        print('API Error: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      products.value = allProducts;
    } else {
      products.value = allProducts.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.shortName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    products.value = allProducts;
  }

  void toggleWishlist(int productId) {
    if (wishlistIds.contains(productId)) {
      wishlistIds.remove(productId);
      Get.snackbar(
        'Removed from Wishlist',
        'Product removed from your wishlist',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } else {
      wishlistIds.add(productId);
      Get.snackbar(
        'Added to Wishlist',
        'Product added to your wishlist',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }

  bool isInWishlist(int productId) {
    return wishlistIds.contains(productId);
  }
}
