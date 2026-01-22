class CategoryProductResponse {
  final Category category;
  final List<CategoryProduct> products;

  CategoryProductResponse({required this.category, required this.products});

  factory CategoryProductResponse.fromJson(Map<String, dynamic> json) {
    return CategoryProductResponse(
      category: Category.fromJson(json['category']),
      products: (json['products'] as List)
          .map((e) => CategoryProduct.fromJson(e))
          .toList(),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String slug;
  final String icon;
  final int status;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.status,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      icon: json['icon'],
      status: json['status'],
      image: json['image'],
    );
  }
}

class CategoryProduct {
  final int id;
  final String name;
  final String shortName;
  final String slug;
  final String thumbImage;
  final int qty;
  final int soldQty;
  final double price;
  final double? offerPrice;
  final String averageRating;
  final String totalSold;
  final int categoryId;

  CategoryProduct({
    required this.id,
    required this.name,
    required this.shortName,
    required this.slug,
    required this.thumbImage,
    required this.qty,
    required this.soldQty,
    required this.price,
    this.offerPrice,
    required this.averageRating,
    required this.totalSold,
    required this.categoryId,
  });

  factory CategoryProduct.fromJson(Map<String, dynamic> json) {
    return CategoryProduct(
      id: json['id'],
      name: json['name'],
      shortName: json['short_name'] ?? '',
      slug: json['slug'] ?? '',
      thumbImage: json['thumb_image'] ?? '',
      qty: json['qty'] ?? 0,
      soldQty: json['sold_qty'] ?? 0,
      price: (json['price'] as num).toDouble(),
      offerPrice: json['offer_price'] != null
          ? (json['offer_price'] as num).toDouble()
          : null,
      averageRating: json['averageRating'].toString(),
      totalSold: json['totalSold'].toString(),
      categoryId: json['category_id'] ?? 0,
    );
  }
}
