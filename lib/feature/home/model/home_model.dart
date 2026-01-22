import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final String slug;
  final String icon;
  final String? image;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      icon: json['icon']?.toString() ?? '',
      image: json['image']?.toString(),
    );
  }

  // Helper method to get IconData from Font Awesome class names
  IconData getIconData() {
    switch (icon) {
      case 'fas fa-anchor':
      case 'fas fa-adjust':
        return Icons.settings;
      case 'fas fa-gamepad':
        return Icons.sports_esports;
      case 'fas fa-mobile-alt':
        return Icons.smartphone;
      case 'fas fa-home':
        return Icons.home;
      case 'fas fa-basketball-ball':
        return Icons.toys;
      case 'fas fa-bicycle':
        return Icons.pedal_bike;
      case 'fas fa-street-view':
        return Icons.person;
      case 'fab fa-android':
        return Icons.face;
      case 'fas fa-cogs':
        return Icons.settings_applications;
      default:
        return Icons.category;
    }
  }
}

class Product {
  final int id;
  final String name;
  final String shortName;
  final String slug;
  final String thumbImage;
  final int qty;
  final double price;
  final double? offerPrice;
  final String averageRating;
  final String totalSold;
  final int categoryId;
  final List<ProductVariant> activeVariants;

  Product({
    required this.id,
    required this.name,
    required this.shortName,
    required this.slug,
    required this.thumbImage,
    required this.qty,
    required this.price,
    this.offerPrice,
    required this.averageRating,
    required this.totalSold,
    required this.categoryId,
    required this.activeVariants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name']?.toString() ?? '',
      shortName: json['short_name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      thumbImage: json['thumb_image']?.toString() ?? '',
      qty: json['qty'] is int ? json['qty'] : int.parse(json['qty'].toString()),
      price: _parseDouble(json['price']),
      offerPrice: json['offer_price'] != null
          ? _parseDouble(json['offer_price'])
          : null,
      averageRating: json['averageRating']?.toString() ?? '0',
      totalSold: json['totalSold']?.toString() ?? '0',
      categoryId: json['category_id'] is int
          ? json['category_id']
          : int.parse(json['category_id'].toString()),
      activeVariants:
          (json['active_variants'] as List?)
              ?.map((v) => ProductVariant.fromJson(v))
              .toList() ??
          [],
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  // Helper method to get the display price
  double get displayPrice => offerPrice ?? price;

  // Helper method to check if product has discount
  bool get hasDiscount => offerPrice != null && offerPrice! < price;

  // Helper method to get discount percentage
  int get discountPercentage {
    if (!hasDiscount) return 0;
    return (((price - offerPrice!) / price) * 100).round();
  }

  // Helper method to get rating as double
  double get ratingValue {
    try {
      return double.parse(averageRating);
    } catch (e) {
      return 0.0;
    }
  }
}

class ProductVariant {
  final int id;
  final String name;
  final int productId;
  final List<VariantItem> activeVariantItems;

  ProductVariant({
    required this.id,
    required this.name,
    required this.productId,
    required this.activeVariantItems,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      name: json['name']?.toString() ?? '',
      productId: json['product_id'] is int
          ? json['product_id']
          : int.parse(json['product_id'].toString()),
      activeVariantItems:
          (json['active_variant_items'] as List?)
              ?.map((i) => VariantItem.fromJson(i))
              .toList() ??
          [],
    );
  }
}

class VariantItem {
  final int id;
  final int productVariantId;
  final String name;
  final double price;

  VariantItem({
    required this.id,
    required this.productVariantId,
    required this.name,
    required this.price,
  });

  factory VariantItem.fromJson(Map<String, dynamic> json) {
    return VariantItem(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      productVariantId: json['product_variant_id'] is int
          ? json['product_variant_id']
          : int.parse(json['product_variant_id'].toString()),
      name: json['name']?.toString() ?? '',
      price: _parseDouble(json['price']),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
