class CartData {
  String session;
  int productId;
  String productType;
  String productCombinationId;
  List<ProductCombination> productCombination = [];
  List<Combination> combination = [];
  int qty;
  List<ProductDetail> productDetail = [];
  ProductGallary productGallary;
  Customer customer;
  List<ParentCategoryDetail> categoryDetail = [];
  var price;
  String productPriceSymbol;
  var discountPrice;
  String productDiscountPriceSymbol;
  var total;

  CartData(
      {this.session,
      this.productId,
      this.productType,
      this.productCombinationId,
      this.productCombination,
      this.combination,
      this.qty,
      this.productDetail,
      this.productGallary,
      this.customer,
      this.categoryDetail,
      this.price,
      this.productPriceSymbol,
      this.discountPrice,
      this.productDiscountPriceSymbol,
      this.total});

  CartData.fromJson(Map<String, dynamic> json) {
    print(json['price']);
    session = json['session'];
    productId = int.parse(json['product_id']);
    productType = json['product_type'];
    productCombinationId = json['product_combination_id'];
    if (json['product_combination'] != null) {
      // productCombination = new List<ProductCombination>();
      json['product_combination'].forEach((v) {
        productCombination.add(new ProductCombination.fromJson(v));
      });
    }
    if (json['combination'] != null) {
      // combination = new List<Combination>();
      json['combination'].forEach((v) {
        combination.add(new Combination.fromJson(v));
      });
    }
    qty = int.parse(json['qty']);
    if (json['product_detail'] != null) {
      // productDetail = new List<ProductDetail>();
      json['product_detail'].forEach((v) {
        productDetail.add(new ProductDetail.fromJson(v));
      });
    }
    productGallary = json['product_gallary'] != null
        ? new ProductGallary.fromJson(json['product_gallary'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['category_detail'] != null) {
      // categoryDetail = new List<ParentCategoryDetail>();
      json['category_detail'].forEach((v) {
        categoryDetail.add(new ParentCategoryDetail.fromJson(v));
      });
    }
    price = json['price'];
    productPriceSymbol = json['product_price_symbol'];
    discountPrice = json['discount_price'];
    productDiscountPriceSymbol = json['product_discount_price_symbol'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session'] = this.session;
    data['product_id'] = this.productId;
    data['product_type'] = this.productType;
    data['product_combination_id'] = this.productCombinationId;
    if (this.productCombination != null) {
      data['product_combination'] =
          this.productCombination.map((v) => v.toJson()).toList();
    }
    if (this.combination != null) {
      data['combination'] = this.combination.map((v) => v.toJson()).toList();
    }
    data['qty'] = this.qty;
    if (this.productDetail != null) {
      data['product_detail'] =
          this.productDetail.map((v) => v.toJson()).toList();
    }
    if (this.productGallary != null) {
      data['product_gallary'] = this.productGallary.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.categoryDetail != null) {
      data['category_detail'] =
          this.categoryDetail.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['product_price_symbol'] = this.productPriceSymbol;
    data['discount_price'] = this.discountPrice;
    data['product_discount_price_symbol'] = this.productDiscountPriceSymbol;
    data['total'] = this.total;
    return data;
  }
}

class ProductCombination {
  String variationId;
  Variation variation;

  ProductCombination({this.variationId, this.variation});

  ProductCombination.fromJson(Map<String, dynamic> json) {
    variationId = json['variation_id'];
    variation = json['variation'] != null
        ? new Variation.fromJson(json['variation'])
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

class Variation {
  int id;
  List<VariationDetail> detail = [];

  Variation({this.id, this.detail});

  Variation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['detail'] != null) {
      //  detail = new List<VariationDetail>();
      json['detail'].forEach((v) {
        detail.add(new VariationDetail.fromJson(v));
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

class VariationDetail {
  String name;
  Language language;

  VariationDetail({this.name, this.language});

  VariationDetail.fromJson(Map<String, dynamic> json) {
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

class Combination {
  int productCombinationId;
  String productId;
  String sku;
  String price;
  String availableQty;
  Gallary gallary;
  List<Combination> combination = [];

  Combination(
      {this.productCombinationId,
      this.productId,
      this.sku,
      this.price,
      this.availableQty,
      this.gallary,
      this.combination});

  Combination.fromJson(Map<String, dynamic> json) {
    productCombinationId = json['product_combination_id'];
    productId = json['product_id'];
    sku = json['sku'];
    price = json['price'];
    availableQty = json['available_qty'];
    gallary =
        json['gallary'] != null ? new Gallary.fromJson(json['gallary']) : null;
    if (json['combination'] != null) {
      ///  combination = new List<Combination>();
      json['combination'].forEach((v) {
        combination.add(new Combination.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_combination_id'] = this.productCombinationId;
    data['product_id'] = this.productId;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['available_qty'] = this.availableQty;
    if (this.gallary != null) {
      data['gallary'] = this.gallary.toJson();
    }
    if (this.combination != null) {
      data['combination'] = this.combination.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gallary {
  int id;
  String gallaryName;
  String gallaryExtension;
  String userId;

  Gallary({this.id, this.gallaryName, this.gallaryExtension, this.userId});

  Gallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryName = json['gallary_name'];
    gallaryExtension = json['gallary_extension'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gallary_name'] = this.gallaryName;
    data['gallary_extension'] = this.gallaryExtension;
    data['user_id'] = this.userId;
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

class ProductGallary {
  int id;
  String gallaryName;
  String gallaryExtension;
  int userId;
  List<GalleryDetail> detail = [];

  ProductGallary(
      {this.id,
      this.gallaryName,
      this.gallaryExtension,
      this.userId,
      this.detail});

  ProductGallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryName = json['gallary_name'];
    gallaryExtension = json['gallary_extension'];
    userId = int.parse(json['user_id']);
    if (json['detail'] != null) {
      //  detail = new List<GalleryDetail>();
      json['detail'].forEach((v) {
        detail.add(new GalleryDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gallary_name'] = this.gallaryName;
    data['gallary_extension'] = this.gallaryExtension;
    data['user_id'] = this.userId;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GalleryDetail {
  int id;
  String gallaryType;
  int gallaryHeight;
  int gallaryWidth;
  String gallaryPath;

  GalleryDetail(
      {this.id,
      this.gallaryType,
      this.gallaryHeight,
      this.gallaryWidth,
      this.gallaryPath});

  GalleryDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryType = json['gallary_type'];
    gallaryHeight = int.parse(json['gallary_height']);
    gallaryWidth = int.parse(json['gallary_width']);
    gallaryPath = json['gallary_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gallary_type'] = this.gallaryType;
    data['gallary_height'] = this.gallaryHeight;
    data['gallary_width'] = this.gallaryWidth;
    data['gallary_path'] = this.gallaryPath;
    return data;
  }
}

class Customer {
  int id;
  String firstName;
  String lastName;
  String email;
  String isSeen;
  String status;
  String hash;
  String createdAt;
  String updatedAt;

  Customer(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.isSeen,
      this.status,
      this.hash,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isSeen = json['is_seen'];
    status = json['status'];
    hash = json['hash'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['is_seen'] = this.isSeen;
    data['status'] = this.status;
    data['hash'] = this.hash;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ParentCategoryDetail {
  int productId;
  ChildCategoryDetail categoryDetail;

  ParentCategoryDetail({this.productId, this.categoryDetail});

  ParentCategoryDetail.fromJson(Map<String, dynamic> json) {
    productId = int.parse(json['product_id']);
    categoryDetail = json['category_detail'] != null
        ? new ChildCategoryDetail.fromJson(json['category_detail'])
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

class ChildCategoryDetail {
  int id;
  int parentId;
  String slug;
  Null sortOrder;
  List<CategoryDetail> detail = [];
  String parentName;

  ChildCategoryDetail(
      {this.id,
      this.parentId,
      this.slug,
      this.sortOrder,
      this.detail,
      this.parentName});

  ChildCategoryDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    slug = json['slug'];
    sortOrder = json['sort_order'];
    if (json['detail'] != null) {
      //  detail = new List<CategoryDetail>();
      json['detail'].forEach((v) {
        detail.add(new CategoryDetail.fromJson(v));
      });
    }
    parentName = json['parent_name'];
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
    data['parent_name'] = this.parentName;
    return data;
  }
}

class CategoryDetail {
  int categoryId;
  String name;
  String description;
  Language language;

  CategoryDetail({this.categoryId, this.name, this.description, this.language});

  CategoryDetail.fromJson(Map<String, dynamic> json) {
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
