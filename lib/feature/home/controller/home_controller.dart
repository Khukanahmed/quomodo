import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quomodo/feature/home/model/home_model.dart';

class HomeController extends GetxController {
  var categories = <Category>[].obs;
  var products = <Product>[].obs;
  var favoriteProducts = <int>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  static const String baseUrl = 'https://mamunuiux.com/flutter_task';
  static const String apiUrl = '$baseUrl/api';

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        loadFromMap(data);
      } else {
        errorMessage.value = 'Failed to load data: ${response.statusCode}';
        isLoading.value = false;
      }
    } catch (e) {
      errorMessage.value = 'Error loading data: $e';
      isLoading.value = false;
      print('Error fetching API: $e');
    }
  }

  void loadFromMap(Map<String, dynamic> data) {
    try {
      isLoading.value = true;

      categories.value = (data['homepage_categories'] as List)
          .map((json) => Category.fromJson(json))
          .toList();

      // Parse products
      products.value = (data['newArrivalProducts'] as List)
          .map((json) => Product.fromJson(json))
          .toList();

      isLoading.value = false;
    } catch (e) {
      print('Error loading data: $e');
      isLoading.value = false;
    }
  }

  var showAllCategories = false.obs;

  List<Category> get visibleCategories {
    if (showAllCategories.value) {
      return categories;
    }
    return categories.take(4).toList();
  }

  void toggleSeeAll() {
    showAllCategories.value = !showAllCategories.value;
  }

  void toggleFavorite(int productId) {
    if (favoriteProducts.contains(productId)) {
      favoriteProducts.remove(productId);
    } else {
      favoriteProducts.add(productId);
    }
  }

  bool isFavorite(int productId) {
    return favoriteProducts.contains(productId);
  }

  // Filter products by category
  List<Product> getProductsByCategory(int categoryId) {
    return products.where((p) => p.categoryId == categoryId).toList();
  }

  // Get featured products
  List<Product> getFeaturedProducts() {
    return products.toList();
  }
}
