class ProductDetailsResponse {
  final ProductDetails product;
  final List<dynamic> gallery;
  final String tags;
  final int totalProductReviewQty;
  final int totalReview;
  final List<dynamic> productReviews;
  final List<dynamic> specifications;
  final RecaptchaSetting recaptchaSetting;
  final List<RelatedProduct> relatedProducts;
  final DefaultProfile defaultProfile;
  final bool isSellerProduct;
  final dynamic seller;
  final int sellerTotalProducts;
  final List<dynamic> thisSellerProducts;
  final int sellerReviewQty;
  final int sellerTotalReview;

  ProductDetailsResponse({
    required this.product,
    required this.gallery,
    required this.tags,
    required this.totalProductReviewQty,
    required this.totalReview,
    required this.productReviews,
    required this.specifications,
    required this.recaptchaSetting,
    required this.relatedProducts,
    required this.defaultProfile,
    required this.isSellerProduct,
    this.seller,
    required this.sellerTotalProducts,
    required this.thisSellerProducts,
    required this.sellerReviewQty,
    required this.sellerTotalReview,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailsResponse(
      product: ProductDetails.fromJson(json['product']),
      gallery: json['gellery'] ?? [],
      tags: json['tags'] ?? '',
      totalProductReviewQty: json['totalProductReviewQty'] ?? 0,
      totalReview: json['totalReview'] ?? 0,
      productReviews: json['productReviews'] ?? [],
      specifications: json['specifications'] ?? [],
      recaptchaSetting: RecaptchaSetting.fromJson(json['recaptchaSetting']),
      relatedProducts:
          (json['relatedProducts'] as List?)
              ?.map((e) => RelatedProduct.fromJson(e))
              .toList() ??
          [],
      defaultProfile: DefaultProfile.fromJson(json['defaultProfile']),
      isSellerProduct: json['is_seller_product'] ?? false,
      seller: json['seller'],
      sellerTotalProducts: json['sellerTotalProducts'] ?? 0,
      thisSellerProducts: json['this_seller_products'] ?? [],
      sellerReviewQty: json['sellerReviewQty'] ?? 0,
      sellerTotalReview: json['sellerTotalReview'] ?? 0,
    );
  }
}

class ProductDetails {
  final int id;
  final String name;
  final String shortName;
  final String slug;
  final String thumbImage;
  final int vendorId;
  final int categoryId;
  final int subCategoryId;
  final int childCategoryId;
  final int brandId;
  final int qty;
  final String weight;
  final int soldQty;
  final String shortDescription;
  final String longDescription;
  final String? videoLink;
  final String? sku;
  final String seoTitle;
  final String seoDescription;
  final double price;
  final double offerPrice;
  final String? tags;
  final int showHomepage;
  final int isUndefine;
  final int isFeatured;
  final int newProduct;
  final int isTop;
  final int isBest;
  final int status;
  final int isSpecification;
  final int approveByAdmin;
  final String isBundleProduct;
  final String bundleProducts;
  final String bundleProductOfferType;
  final String bundleProductOffer;
  final String createdAt;
  final String updatedAt;
  final String averageRating;
  final String totalSold;
  final Category? category;
  final dynamic brand;
  final List<dynamic> activeVariants;
  final List<dynamic> avgReview;

  ProductDetails({
    required this.id,
    required this.name,
    required this.shortName,
    required this.slug,
    required this.thumbImage,
    required this.vendorId,
    required this.categoryId,
    required this.subCategoryId,
    required this.childCategoryId,
    required this.brandId,
    required this.qty,
    required this.weight,
    required this.soldQty,
    required this.shortDescription,
    required this.longDescription,
    this.videoLink,
    this.sku,
    required this.seoTitle,
    required this.seoDescription,
    required this.price,
    required this.offerPrice,
    this.tags,
    required this.showHomepage,
    required this.isUndefine,
    required this.isFeatured,
    required this.newProduct,
    required this.isTop,
    required this.isBest,
    required this.status,
    required this.isSpecification,
    required this.approveByAdmin,
    required this.isBundleProduct,
    required this.bundleProducts,
    required this.bundleProductOfferType,
    required this.bundleProductOffer,
    required this.createdAt,
    required this.updatedAt,
    required this.averageRating,
    required this.totalSold,
    this.category,
    this.brand,
    required this.activeVariants,
    required this.avgReview,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      shortName: json['short_name'] ?? '',
      slug: json['slug'] ?? '',
      thumbImage: json['thumb_image'] ?? '',
      vendorId: json['vendor_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      subCategoryId: json['sub_category_id'] ?? 0,
      childCategoryId: json['child_category_id'] ?? 0,
      brandId: json['brand_id'] ?? 0,
      qty: json['qty'] ?? 0,
      weight: json['weight'] ?? '',
      soldQty: json['sold_qty'] ?? 0,
      shortDescription: json['short_description'] ?? '',
      longDescription: json['long_description'] ?? '',
      videoLink: json['video_link'],
      sku: json['sku'],
      seoTitle: json['seo_title'] ?? '',
      seoDescription: json['seo_description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      offerPrice: (json['offer_price'] ?? 0).toDouble(),
      tags: json['tags'],
      showHomepage: json['show_homepage'] ?? 0,
      isUndefine: json['is_undefine'] ?? 0,
      isFeatured: json['is_featured'] ?? 0,
      newProduct: json['new_product'] ?? 0,
      isTop: json['is_top'] ?? 0,
      isBest: json['is_best'] ?? 0,
      status: json['status'] ?? 0,
      isSpecification: json['is_specification'] ?? 0,
      approveByAdmin: json['approve_by_admin'] ?? 0,
      isBundleProduct: json['is_bundle_product'] ?? 'no',
      bundleProducts: json['bundle_products'] ?? '',
      bundleProductOfferType: json['bundle_product_offer_type'] ?? 'fixed',
      bundleProductOffer: json['bundle_product_offer'] ?? '0.00',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      averageRating: json['averageRating']?.toString() ?? '0',
      totalSold: json['totalSold']?.toString() ?? '0',
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      brand: json['brand'],
      activeVariants: json['active_variants'] ?? [],
      avgReview: json['avg_review'] ?? [],
    );
  }

  String get fullImageUrl => 'https://mamunuiux.com/flutter_task/$thumbImage';
  double get discountPercentage =>
      price > 0 ? ((price - offerPrice) / price * 100) : 0;
  bool get hasDiscount => offerPrice < price;
}

class Category {
  final int id;
  final String name;
  final String slug;
  final String icon;
  final int status;
  final String image;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      icon: json['icon'] ?? '',
      status: json['status'] ?? 0,
      image: json['image'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class RecaptchaSetting {
  final int id;
  final String siteKey;
  final String secretKey;
  final int status;
  final String? createdAt;
  final String updatedAt;

  RecaptchaSetting({
    required this.id,
    required this.siteKey,
    required this.secretKey,
    required this.status,
    this.createdAt,
    required this.updatedAt,
  });

  factory RecaptchaSetting.fromJson(Map<String, dynamic> json) {
    return RecaptchaSetting(
      id: json['id'] ?? 0,
      siteKey: json['site_key'] ?? '',
      secretKey: json['secret_key'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class RelatedProduct {
  final int id;
  final String name;
  final String shortName;
  final String slug;
  final String thumbImage;
  final int vendorId;
  final int categoryId;
  final int subCategoryId;
  final int childCategoryId;
  final int brandId;
  final int qty;
  final String weight;
  final int soldQty;
  final String shortDescription;
  final String longDescription;
  final String? videoLink;
  final String? sku;
  final String seoTitle;
  final String seoDescription;
  final double price;
  final double offerPrice;
  final String? tags;
  final int showHomepage;
  final int isUndefine;
  final int isFeatured;
  final int newProduct;
  final int isTop;
  final int isBest;
  final int status;
  final int isSpecification;
  final int approveByAdmin;
  final String isBundleProduct;
  final String bundleProducts;
  final String bundleProductOfferType;
  final String bundleProductOffer;
  final String createdAt;
  final String updatedAt;
  final String averageRating;
  final dynamic totalSold;
  final List<dynamic> activeVariants;

  RelatedProduct({
    required this.id,
    required this.name,
    required this.shortName,
    required this.slug,
    required this.thumbImage,
    required this.vendorId,
    required this.categoryId,
    required this.subCategoryId,
    required this.childCategoryId,
    required this.brandId,
    required this.qty,
    required this.weight,
    required this.soldQty,
    required this.shortDescription,
    required this.longDescription,
    this.videoLink,
    this.sku,
    required this.seoTitle,
    required this.seoDescription,
    required this.price,
    required this.offerPrice,
    this.tags,
    required this.showHomepage,
    required this.isUndefine,
    required this.isFeatured,
    required this.newProduct,
    required this.isTop,
    required this.isBest,
    required this.status,
    required this.isSpecification,
    required this.approveByAdmin,
    required this.isBundleProduct,
    required this.bundleProducts,
    required this.bundleProductOfferType,
    required this.bundleProductOffer,
    required this.createdAt,
    required this.updatedAt,
    required this.averageRating,
    this.totalSold,
    required this.activeVariants,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      shortName: json['short_name'] ?? '',
      slug: json['slug'] ?? '',
      thumbImage: json['thumb_image'] ?? '',
      vendorId: json['vendor_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      subCategoryId: json['sub_category_id'] ?? 0,
      childCategoryId: json['child_category_id'] ?? 0,
      brandId: json['brand_id'] ?? 0,
      qty: json['qty'] ?? 0,
      weight: json['weight'] ?? '',
      soldQty: json['sold_qty'] ?? 0,
      shortDescription: json['short_description'] ?? '',
      longDescription: json['long_description'] ?? '',
      videoLink: json['video_link'],
      sku: json['sku'],
      seoTitle: json['seo_title'] ?? '',
      seoDescription: json['seo_description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      offerPrice: (json['offer_price'] ?? 0).toDouble(),
      tags: json['tags'],
      showHomepage: json['show_homepage'] ?? 0,
      isUndefine: json['is_undefine'] ?? 0,
      isFeatured: json['is_featured'] ?? 0,
      newProduct: json['new_product'] ?? 0,
      isTop: json['is_top'] ?? 0,
      isBest: json['is_best'] ?? 0,
      status: json['status'] ?? 0,
      isSpecification: json['is_specification'] ?? 0,
      approveByAdmin: json['approve_by_admin'] ?? 0,
      isBundleProduct: json['is_bundle_product'] ?? 'no',
      bundleProducts: json['bundle_products'] ?? '',
      bundleProductOfferType: json['bundle_product_offer_type'] ?? 'fixed',
      bundleProductOffer: json['bundle_product_offer'] ?? '0.00',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      averageRating: json['averageRating']?.toString() ?? '0',
      totalSold: json['totalSold'],
      activeVariants: json['active_variants'] ?? [],
    );
  }

  String get fullImageUrl => 'https://mamunuiux.com/flutter_task/$thumbImage';
  double get discountPercentage =>
      price > 0 ? ((price - offerPrice) / price * 100) : 0;
}

class DefaultProfile {
  final String image;

  DefaultProfile({required this.image});

  factory DefaultProfile.fromJson(Map<String, dynamic> json) {
    return DefaultProfile(image: json['image'] ?? '');
  }

  String get fullImageUrl => 'https://mamunuiux.com/flutter_task/$image';
}
