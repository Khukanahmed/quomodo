class ProductItem {
  final int id;
  final String name;
  final String shortName;
  final String slug;
  final String thumbImage;
  final int qty;
  final int soldQty;
  final double price;
  final double offerPrice;
  final String averageRating;
  final String totalSold;
  final int categoryId;
  final List<dynamic> activeVariants;

  ProductItem({
    required this.id,
    required this.name,
    required this.shortName,
    required this.slug,
    required this.thumbImage,
    required this.qty,
    required this.soldQty,
    required this.price,
    required this.offerPrice,
    required this.averageRating,
    required this.totalSold,
    required this.categoryId,
    required this.activeVariants,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      shortName: json['short_name'] ?? '',
      slug: json['slug'] ?? '',
      thumbImage: json['thumb_image'] ?? '',
      qty: json['qty'] ?? 0,
      soldQty: json['sold_qty'] ?? 0,
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] ?? 0.0),
      offerPrice: (json['offer_price'] is int)
          ? (json['offer_price'] as int).toDouble()
          : (json['offer_price'] ?? 0.0),
      averageRating: json['averageRating']?.toString() ?? '0',
      totalSold: json['totalSold']?.toString() ?? '0',
      categoryId: json['category_id'] ?? 0,
      activeVariants: json['active_variants'] ?? [],
    );
  }
}

class ProductResponse {
  final List<ProductItem> products;
  final int currentPage;
  final int lastPage;
  final int total;
  final String? nextPageUrl;

  ProductResponse({
    required this.products,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.nextPageUrl,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    final productsData = json['products'] ?? {};
    final List<dynamic> dataList = productsData['data'] ?? [];

    return ProductResponse(
      products: dataList.map((item) => ProductItem.fromJson(item)).toList(),
      currentPage: productsData['current_page'] ?? 1,
      lastPage: productsData['last_page'] ?? 1,
      total: productsData['total'] ?? 0,
      nextPageUrl: productsData['next_page_url'],
    );
  }
}
