class Product {
  int productId;
  String productType;
  String productSlug;
  String productVideoUrl;
  ProductGallary productGallary;
  List<ProductGallary> productGallaryDetail = [];
  var productPrice;
  var productDiscountPrice;
  ProductUnit productUnit;
  String productWeight;
  String productStatus;
  ProductBrand productBrand;
  String productView;
  int isFeatured;
  String isPoints;
  int productMinOrder;
  int productMaxOrder;
  String seoMetaTag;
  String seoDesc;
  var productRating;
  List<ProductCategory> category = [];
  List<ProductDetail> detail = [];
  List<ProductAttribute> attribute = [];
  List<ProductCombination> productCombination = [];
  List<Reviews> reviews = [];
  ProductsStock stock;

  Product(
      {this.productId,
      this.productType,
      this.productSlug,
      this.productVideoUrl,
      this.productGallary,
      this.productGallaryDetail,
      this.productPrice,
      this.productDiscountPrice,
      this.productUnit,
      this.productWeight,
      this.productStatus,
      this.productBrand,
      this.productView,
      this.isFeatured,
      this.isPoints,
      this.productMinOrder,
      this.productMaxOrder,
      this.seoMetaTag,
      this.seoDesc,
      this.productRating,
      this.category,
      this.detail,
      this.attribute,
      this.productCombination,
      this.reviews,
      this.stock});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productType = json['product_type'];
    productSlug = json['product_slug'];
    productVideoUrl = json['product_video_url'];
    productGallary = json['product_gallary'] != null
        ? new ProductGallary.fromJson(json['product_gallary'])
        : null;
    if (json['product_gallary_detail'] != null) {
      productGallaryDetail = [];
      json['product_gallary_detail'].forEach((v) {
        productGallaryDetail.add(new ProductGallary.fromJson(v));
      });
    }
    productPrice = json['product_price'];
    productDiscountPrice = json['product_discount_price'];
    productUnit = json['product_unit'] != null
        ? new ProductUnit.fromJson(json['product_unit'])
        : null;
    productWeight = json['product_weight'];
    productStatus = json['product_status'];
    productBrand = json['product_brand'] != null
        ? new ProductBrand.fromJson(json['product_brand'])
        : null;
    productView = json['product_view'];
    isFeatured = int.parse(json['is_featured']);
    isPoints = json['is_points'];
    productMinOrder = int.parse(json['product_min_order']);
    productMaxOrder = int.parse(json['product_max_order']);
    seoMetaTag = json['seo_meta_tag'];
    seoDesc = json['seo_desc'];
    productRating = json['product_rating'];
    if (json['category'] != null) {
      category = [];
      json['category'].forEach((v) {
        category.add(new ProductCategory.fromJson(v));
      });
    }
    if (json['detail'] != null) {
      detail = [];
      json['detail'].forEach((v) {
        detail.add(new ProductDetail.fromJson(v));
      });
    }
    if (json['attribute'] != null) {
      attribute = [];
      json['attribute'].forEach((v) {
        attribute.add(new ProductAttribute.fromJson(v));
      });
    }
    if (json['product_combination'] != null) {
      productCombination = [];
      json['product_combination'].forEach((v) {
        productCombination.add(new ProductCombination.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      // reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
    stock = json['stock'] != null
        ? new ProductsStock.fromJson(json['stock'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_type'] = this.productType;
    data['product_slug'] = this.productSlug;
    data['product_video_url'] = this.productVideoUrl;
    if (this.productGallary != null) {
      data['product_gallary'] = this.productGallary.toJson();
    }
    if (this.productGallaryDetail != null) {
      data['product_gallary_detail'] =
          this.productGallaryDetail.map((v) => v.toJson()).toList();
    }
    data['product_price'] = this.productPrice;
    data['product_discount_price'] = this.productDiscountPrice;
    if (this.productUnit != null) {
      data['product_unit'] = this.productUnit.toJson();
    }
    data['product_weight'] = this.productWeight;
    data['product_status'] = this.productStatus;
    if (this.productBrand != null) {
      data['product_brand'] = this.productBrand.toJson();
    }
    data['product_view'] = this.productView;
    data['is_featured'] = this.isFeatured;
    data['is_points'] = this.isPoints;
    data['product_min_order'] = this.productMinOrder;
    data['product_max_order'] = this.productMaxOrder;
    data['seo_meta_tag'] = this.seoMetaTag;
    data['seo_desc'] = this.seoDesc;
    data['product_rating'] = this.productRating;
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    if (this.attribute != null) {
      data['attribute'] = this.attribute.map((v) => v.toJson()).toList();
    }
    if (this.productCombination != null) {
      data['product_combination'] =
          this.productCombination.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    if (this.stock != null) {
      data['stock'] = this.stock.toJson();
    }
    return data;
  }
}

class Reviews {
  int id;
  String comment;
  String rating;
  String status;

  Reviews({this.id, this.comment, this.rating, this.status});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['status'] = this.status;
    return data;
  }
}

class ProductGallary {
  int id;
  String gallaryName;
  List<PGDetail> detail = [];

  ProductGallary({this.id, this.gallaryName, this.detail});

  ProductGallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryName = json['gallary_name'];
    if (json['detail'] != null) {
      detail = [];
      json['detail'].forEach((v) {
        detail.add(new PGDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gallary_name'] = this.gallaryName;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PGDetail {
  int id;
  String gallaryType;
  String gallaryPath;

  PGDetail({this.id, this.gallaryType, this.gallaryPath});

  PGDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryType = json['gallary_type'];
    gallaryPath = json['gallary_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gallary_type'] = this.gallaryType;
    data['gallary_path'] = this.gallaryPath;
    return data;
  }
}

class ProductUnit {
  int id;
  int isActive;
  String detail;

  ProductUnit({this.id, this.isActive, this.detail});

  ProductUnit.fromJson(Map<String, dynamic> json) {
    print(json['unit_name']);
    id = json['id'];
    isActive = int.parse(json['is_active']);
    detail = json['unit_name']['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_active'] = this.isActive;

    return data;
  }
}

class ProductBrand {
  int brandId;
  String brandName;
  String brandSlug;
  ProductBrandGallary gallary;
  String brandStatus;

  ProductBrand(
      {this.brandId,
      this.brandName,
      this.brandSlug,
      this.gallary,
      this.brandStatus});

  ProductBrand.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    brandSlug = json['brand_slug'];
    gallary = json['gallary'] != null
        ? new ProductBrandGallary.fromJson(json['gallary'])
        : null;
    brandStatus = json['brand_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['brand_slug'] = this.brandSlug;
    if (this.gallary != null) {
      data['gallary'] = this.gallary.toJson();
    }
    data['brand_status'] = this.brandStatus;
    return data;
  }
}

class ProductBrandGallary {
  int id;
  String name;
  String extension;
  int userId;
  int createdBy;
  String updatedBy;
  String deletedAt;
  String createdAt;
  String updatedAt;

  ProductBrandGallary(
      {this.id,
      this.name,
      this.extension,
      this.userId,
      this.createdBy,
      this.updatedBy,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  ProductBrandGallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    extension = json['extension'];
    userId = int.parse(json['user_id']);
    createdBy = int.parse(json['created_by']);
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['extension'] = this.extension;
    data['user_id'] = this.userId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProductCategory {
  int productId;
  CategoryDetail categoryDetail;

  ProductCategory({this.productId, this.categoryDetail});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    productId = int.parse(json['product_id']);
    categoryDetail = json['category_detail'] != null
        ? new CategoryDetail.fromJson(json['category_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    if (this.categoryDetail != null) {
      data['category_detail'] = this.categoryDetail.toJson();
    }
    return data;
  }
}

class CategoryDetail {
  int id;
  int parentId;
  String slug;
  String sortOrder;
  List<CategoryDetailDetail> detail = [];

  CategoryDetail(
      {this.id, this.parentId, this.slug, this.sortOrder, this.detail});

  CategoryDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    slug = json['slug'];
    sortOrder = json['sort_order'];
    if (json['detail'] != null) {
      detail = [];
      json['detail'].forEach((v) {
        detail.add(new CategoryDetailDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['slug'] = this.slug;
    data['sort_order'] = this.sortOrder;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDetailDetail {
  int categoryId;
  String name;
  String description;
  Language language;

  CategoryDetailDetail(
      {this.categoryId, this.name, this.description, this.language});

  CategoryDetailDetail.fromJson(Map<String, dynamic> json) {
    categoryId = int.parse(json['category_id']);
    name = json['name'];
    description = json['description'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    return data;
  }
}

class Language {
  int id;
  String languageName;
  String code;
  int isDefault;
  String direction;
  Null directory;

  Language(
      {this.id,
      this.languageName,
      this.code,
      this.isDefault,
      this.direction,
      this.directory});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageName = json['language_name'];
    code = json['code'];
    isDefault = int.parse(json['is_default']);
    direction = json['direction'];
    directory = json['directory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language_name'] = this.languageName;
    data['code'] = this.code;
    data['is_default'] = this.isDefault;
    data['direction'] = this.direction;
    data['directory'] = this.directory;
    return data;
  }
}

class ProductDetail {
  int productId;
  String title;
  String desc;
  Language language;

  ProductDetail({this.productId, this.title, this.desc, this.language});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    productId = int.parse(json['product_id']);
    title = json['title'];
    desc = json['desc'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['title'] = this.title;
    data['desc'] = this.desc;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    return data;
  }
}

class ProductAttribute {
  String productId;
  Attributes attributes;
  List<ProductAttributeVariations> variations = [];

  ProductAttribute({this.productId, this.attributes, this.variations});

  ProductAttribute.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
    if (json['variations'] != null) {
      variations = [];
      json['variations'].forEach((v) {
        variations.add(new ProductAttributeVariations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    if (this.variations != null) {
      data['variations'] = this.variations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  int attributeId;
  List<AttributeDetail> detail = [];

  Attributes({this.attributeId, this.detail});

  Attributes.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    if (json['detail'] != null) {
      detail = [];
      json['detail'].forEach((v) {
        detail.add(new AttributeDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_id'] = this.attributeId;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributeDetail {
  String name;

  AttributeDetail({this.name});

  AttributeDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class ProductAttributeVariations {
  ProductVariation productVariation;

  ProductAttributeVariations({this.productVariation});

  ProductAttributeVariations.fromJson(Map<String, dynamic> json) {
    productVariation = json['product_variation'] != null
        ? new ProductVariation.fromJson(json['product_variation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productVariation != null) {
      data['product_variation'] = this.productVariation.toJson();
    }
    return data;
  }
}

class ProductVariation {
  int id;
  List<Detail> detail = [];

  ProductVariation({this.id, this.detail});

  ProductVariation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['detail'] != null) {
      detail = [];
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String name;
  Language language;

  Detail({this.name, this.language});

  Detail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    return data;
  }
}

class ProductCombination {
  int productCombinationId;
  String productId;
  int price;
  ProductCombinationGallary gallary;
  List<Combination> combination = [];

  ProductCombination(
      {this.productCombinationId,
      this.productId,
      this.price,
      this.gallary,
      this.combination});

  ProductCombination.fromJson(Map<String, dynamic> json) {
    productCombinationId = json['product_combination_id'];
    productId = json['product_id'];
    price = json['price'];
    gallary = json['gallary'] != null
        ? new ProductCombinationGallary.fromJson(json['gallary'])
        : null;
    if (json['combination'] != null) {
      combination = [];
      json['combination'].forEach((v) {
        combination.add(new Combination.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_combination_id'] = this.productCombinationId;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    if (this.gallary != null) {
      data['gallary'] = this.gallary.toJson();
    }
    if (this.combination != null) {
      data['combination'] = this.combination.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCombinationGallary {
  int id;
  String gallaryName;

  ProductCombinationGallary({this.id, this.gallaryName});

  ProductCombinationGallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryName = json['gallary_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gallary_name'] = this.gallaryName;
    return data;
  }
}

class Combination {
  String variationId;
  ProductVariation variation;

  Combination({this.variationId, this.variation});

  Combination.fromJson(Map<String, dynamic> json) {
    variationId = json['variation_id'];
    variation = json['variation'] != null
        ? new ProductVariation.fromJson(json['variation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variation_id'] = this.variationId;
    if (this.variation != null) {
      data['variation'] = this.variation.toJson();
    }
    return data;
  }
}

class ProductsStock {
  int productId;
  Null productCombinationId;
  String productType;
  int warehouseId;
  String stockIn;
  String stockOut;
  String remainingStock;
  int price;
  var discountPrice;

  ProductsStock(
      {this.productId,
      this.productCombinationId,
      this.productType,
      this.warehouseId,
      this.stockIn,
      this.stockOut,
      this.remainingStock,
      this.price,
      this.discountPrice});

  ProductsStock.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productCombinationId = json['product_combination_id'];
    productType = json['product_type'];
    warehouseId = json['warehouse_id'];
    stockIn = json['stock_in'];
    stockOut = json['stock_out'];
    remainingStock = json['remaining_stock'];
    price = json['price'];
    discountPrice = json['discount_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_combination_id'] = this.productCombinationId;
    data['product_type'] = this.productType;
    data['warehouse_id'] = this.warehouseId;
    data['stock_in'] = this.stockIn;
    data['stock_out'] = this.stockOut;
    data['remaining_stock'] = this.remainingStock;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    return data;
  }
}
