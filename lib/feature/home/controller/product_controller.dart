import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';

import 'package:quomodo/feature/home/model/product_details_model.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var currentProduct = Rx<ProductDetailsResponse?>(null);
  var cartItemCount = 0.obs;
  var isFavorite = false.obs;
  var selectedImageIndex = 0.obs;
  var productName = ''.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      final productName = Get.arguments;
      fetchProductDetail(productName);
    }

    print('ProductController initialized with ID: ${Get.arguments}');
  }

  void fetchProductDetail(String name) async {
    try {
      isLoading(true);
      final response = await https.get(
        Uri.parse('https://mamunuiux.com/flutter_task/api/product/$name'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final productResponse = ProductDetailsResponse.fromJson(jsonData);

        if (productResponse.product != null) {
          currentProduct.value = productResponse;
        } else {
          throw Exception('Product not found');
        }
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void addToCart() {
    cartItemCount.value++;
    Get.snackbar(
      'Success',
      'Product added to cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void selectImage(int index) {
    selectedImageIndex.value = index;
  }
}
