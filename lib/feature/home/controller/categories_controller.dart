import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quomodo/core/network_caller/endpoints.dart';
import 'package:quomodo/feature/home/model/category_model.dart';

class CategoriesController extends GetxController {
  final isLoading = true.obs;
  final categoryId = 0.obs;

  final categoryResponse = Rxn<CategoryProductResponse>();
  final products = <CategoryProduct>[].obs;

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
}
