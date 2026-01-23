import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quomodo/core/network_caller/endpoints.dart';
import 'package:quomodo/feature/home/model/all_product_model.dart';

class AllProductController extends GetxController {
  var products = <ProductItem>[].obs;
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var totalProducts = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
    if (kDebugMode) {
      print("AllProductController initialized");
    }
  }

  Future<void> fetchAllProducts({int page = 1}) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final response = await https.get(
        Uri.parse('${Urls.baseUrl}/product?page=$page'),
        headers: {'accept': 'application/json'},
      );

      if (kDebugMode) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      }

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final productResponse = ProductResponse.fromJson(jsonData);

        if (page == 1) {
          products.value = productResponse.products;
        } else {
          products.addAll(productResponse.products);
        }

        currentPage.value = productResponse.currentPage;
        lastPage.value = productResponse.lastPage;
        totalProducts.value = productResponse.total;

        if (kDebugMode) {
          print('Loaded ${productResponse.products.length} products');
          print('Total products: ${productResponse.total}');
        }
      } else {
        hasError.value = true;
        errorMessage.value = 'Failed to load products: ${response.statusCode}';
        if (kDebugMode) {
          print(errorMessage.value);
        }
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Error: $e';
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    if (currentPage.value < lastPage.value && !isLoading.value) {
      await fetchAllProducts(page: currentPage.value + 1);
    }
  }

  Future<void> refreshProducts() async {
    products.clear();
    await fetchAllProducts(page: 1);
  }

  double getDiscountPercentage(double price, double offerPrice) {
    if (price <= 0) return 0;
    return ((price - offerPrice) / price * 100);
  }
}
