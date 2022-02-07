class OrdersData {
  int orderId;
  String billingFirstName;
  String billingLastName;
  String billingCompany;
  String billingStreetAadress;
  String billingSuburb;
  String billingCity;
  String billingPostcode;
  String billingPhone;
  String deliveryFirstName;
  String deliveryLastName;
  String deliveryCompany;
  String deliveryStreetAadress;
  dynamic deliverySuburb;
  String deliveryCity;
  String deliveryPostcode;
  String deliveryPhone;
  dynamic ccType;
  dynamic ccOwner;
  dynamic ccNumber;
  dynamic ccExpiry;
  var currencyValue;
  var orderPrice;
  var shippingCost;
  String shippingMethod;
  dynamic shippingDuration;
  String orderNotes;
  String isSeen;
  var couponCode;
  var couponAmount;
  String paymentMethod;
  var transactionId;
  String orderStatus;
  var totalTax;
  String orderDate;
  List<OrderDetail> orderDetail = [];

  OrdersData(
      {this.orderId,
      this.billingFirstName,
      this.billingLastName,
      this.billingCompany,
      this.billingStreetAadress,
      this.billingSuburb,
      this.billingCity,
      this.billingPostcode,
      this.billingPhone,
      this.deliveryFirstName,
      this.deliveryLastName,
      this.deliveryCompany,
      this.deliveryStreetAadress,
      this.deliverySuburb,
      this.deliveryCity,
      this.deliveryPostcode,
      this.deliveryPhone,
      this.ccType,
      this.ccOwner,
      this.ccNumber,
      this.ccExpiry,
      this.currencyValue,
      this.orderPrice,
      this.shippingCost,
      this.shippingMethod,
      this.shippingDuration,
      this.orderNotes,
      this.isSeen,
      this.couponCode,
      this.couponAmount,
      this.paymentMethod,
      this.transactionId,
      this.orderStatus,
      this.totalTax,
      this.orderDate,
      this.orderDetail});

  OrdersData.fromJson(Map<String, dynamic> json) {
    print(json['order_notes'].runtimeType);
    orderId = json['order_id'];
    billingFirstName = json['billing_first_name'];
    billingLastName = json['billing_last_name'];
    billingCompany =
        json['billing_company'] == null ? "Null" : json['billing_company'];
    billingStreetAadress = json['billing_street_aadress'];
    billingSuburb = json['billing_suburb'];
    billingCity = json['billing_city'];
    billingPostcode = json['billing_postcode'];
    billingPhone = json['billing_phone'];
    deliveryFirstName = json['delivery_first_name'];
    deliveryLastName = json['delivery_last_name'];
    deliveryCompany = json['delivery_company'] ?? "Null";
    deliveryStreetAadress = json['delivery_street_aadress'];
    deliverySuburb = json['delivery_suburb'] ?? "Null";
    deliveryCity = json['delivery_city'];
    deliveryPostcode = json['delivery_postcode'];
    deliveryPhone = json['delivery_phone'];
    ccType = json['cc_type'] == null ? "Null" : json['cc_type'];
    ccOwner = json['cc_owner'] == null ? "Null" : json['cc_owner'];
    ccNumber = json['cc_number'] == null ? "Null" : json['cc_number'];
    ccExpiry = json['cc_expiry'] == null ? "Null" : json['cc_expiry'];
    currencyValue = json['currency_value'];
    orderPrice = json['order_price'];
    shippingCost = json['shipping_cost'];
    shippingMethod = json['shipping_method'];
    shippingDuration =
        json['shipping_duration'] == null ? "Null" : json['shipping_duration'];
    // orderNotes = json['order_notes'] "Null";
    isSeen = json['is_seen'];
    couponCode = json['coupon_code'] == null ? "Null" : json['coupon_code'];
    couponAmount =
        json['coupon_amount'] == null ? "Null" : json['coupon_amount'];
    paymentMethod = json['payment_method'];
    transactionId =
        json['transaction_id'] == null ? "Null" : json['transaction_id'];
    orderStatus = json['order_status'];
    totalTax = json['total_tax'];
    orderDate = json['order_date'];
    if (json['order_detail'] != null) {
      // orderDetail = new List<OrderDetail>();
      json['order_detail'].forEach((v) {
        orderDetail.add(new OrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['billing_first_name'] = this.billingFirstName;
    data['billing_last_name'] = this.billingLastName;
    data['billing_company'] = this.billingCompany;
    data['billing_street_aadress'] = this.billingStreetAadress;
    data['billing_suburb'] = this.billingSuburb;
    data['billing_city'] = this.billingCity;
    data['billing_postcode'] = this.billingPostcode;
    data['billing_phone'] = this.billingPhone;
    data['delivery_first_name'] = this.deliveryFirstName;
    data['delivery_last_name'] = this.deliveryLastName;
    data['delivery_company'] = this.deliveryCompany;
    data['delivery_street_aadress'] = this.deliveryStreetAadress;
    data['delivery_suburb'] = this.deliverySuburb;
    data['delivery_city'] = this.deliveryCity;
    data['delivery_postcode'] = this.deliveryPostcode;
    data['delivery_phone'] = this.deliveryPhone;
    data['cc_type'] = this.ccType;
    data['cc_owner'] = this.ccOwner;
    data['cc_number'] = this.ccNumber;
    data['cc_expiry'] = this.ccExpiry;
    data['currency_value'] = this.currencyValue;
    data['order_price'] = this.orderPrice;
    data['shipping_cost'] = this.shippingCost;
    data['shipping_method'] = this.shippingMethod;
    data['shipping_duration'] = this.shippingDuration;
    data['order_notes'] = this.orderNotes;
    data['is_seen'] = this.isSeen;
    data['coupon_code'] = this.couponCode;
    data['coupon_amount'] = this.couponAmount;
    data['payment_method'] = this.paymentMethod;
    data['transaction_id'] = this.transactionId;
    data['order_status'] = this.orderStatus;
    data['total_tax'] = this.totalTax;
    data['order_date'] = this.orderDate;
    if (this.orderDetail != null) {
      data['order_detail'] = this.orderDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetail {
  Product product;
  String productPrice;
  var productDiscount;
  String productTax;
  String productQty;
  String productTotal;

  OrderDetail(
      {this.product,
      this.productPrice,
      this.productDiscount,
      this.productTax,
      this.productQty,
      this.productTotal});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    productPrice =
        json['product_price'] == null ? "0.0" : json['product_price'];
    productDiscount =
        json['product_discount'] == null ? "Null" : json['product_discount'];
    productTax = json['product_tax'];
    productQty = json['product_qty'];
    productTotal = json['product_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['product_price'] = this.productPrice;
    data['product_discount'] = this.productDiscount;
    data['product_tax'] = this.productTax;
    data['product_qty'] = this.productQty;
    data['product_total'] = this.productTotal;
    return data;
  }
}

class Product {
  int productId;
  String productType;
  String productSlug;
  ProductGallary productGallary;
  List<ProductGallaryDetail> productGallaryDetail = [];
  var productPrice;
  var productDiscountPrice;
  String productStatus;
  ProductBrand productBrand;
  String isFeatured;
  String isPoints;
  List<Detail> detail = [];
  List<Reviews> reviews = [];
  Stock stock;

  Product(
      {this.productId,
      this.productType,
      this.productSlug,
      this.productGallary,
      this.productGallaryDetail,
      this.productPrice,
      this.productDiscountPrice,
      this.productStatus,
      this.productBrand,
      this.isFeatured,
      this.isPoints,
      this.detail,
      this.reviews,
      this.stock});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productType = json['product_type'];
    productSlug = json['product_slug'];
    productGallary = json['product_gallary'] != null
        ? new ProductGallary.fromJson(json['product_gallary'])
        : null;
    if (json['product_gallary_detail'] != null) {
      // productGallaryDetail = new List<ProductGallaryDetail>();
      json['product_gallary_detail'].forEach((v) {
        productGallaryDetail.add(new ProductGallaryDetail.fromJson(v));
      });
    }
    productPrice = json['product_price'] == null ? 0.0 : json['product_price'];
    productDiscountPrice = json['product_discount_price'];
    productStatus = json['product_status'];
    productBrand = json['product_brand'] != null
        ? new ProductBrand.fromJson(json['product_brand'])
        : null;
    isFeatured = json['is_featured'];
    isPoints = json['is_points'];
    if (json['detail'] != null) {
      // detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      // reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
    stock = json['stock'] != null ? new Stock.fromJson(json['stock']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_type'] = this.productType;
    data['product_slug'] = this.productSlug;
    if (this.productGallary != null) {
      data['product_gallary'] = this.productGallary.toJson();
    }
    if (this.productGallaryDetail != null) {
      data['product_gallary_detail'] =
          this.productGallaryDetail.map((v) => v.toJson()).toList();
    }
    data['product_price'] = this.productPrice;
    data['product_discount_price'] = this.productDiscountPrice;
    data['product_status'] = this.productStatus;
    if (this.productBrand != null) {
      data['product_brand'] = this.productBrand.toJson();
    }
    data['is_featured'] = this.isFeatured;
    data['is_points'] = this.isPoints;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
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

class ProductGallary {
  int id;
  String gallaryName;
  String gallaryExtension;
  String userId;
  List<Detail> detail = [];

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
    userId = json['user_id'];
    if (json['detail'] != null) {
      // detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
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

class Detail {
  int id;
  String gallaryType;
  String gallaryHeight;
  String gallaryWidth;
  String gallaryPath;

  Detail(
      {this.id,
      this.gallaryType,
      this.gallaryHeight,
      this.gallaryWidth,
      this.gallaryPath});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryType = json['gallary_type'];
    gallaryHeight = json['gallary_height'];
    gallaryWidth = json['gallary_width'];
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

class ProductGallaryDetail {
  int id;
  String gallaryName;
  String gallaryExtension;
  var userId;

  ProductGallaryDetail(
      {this.id, this.gallaryName, this.gallaryExtension, this.userId});

  ProductGallaryDetail.fromJson(Map<String, dynamic> json) {
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

class ProductBrand {
  int brandId;
  String brandName;
  String brandSlug;
  Gallary gallary;
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
    gallary =
        json['gallary'] != null ? new Gallary.fromJson(json['gallary']) : null;
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

class Gallary {
  int id;
  String name;
  String extension;
  String userId;
  String createdBy;
  var updatedBy;
  var deletedAt;
  var createdAt;
  var updatedAt;

  Gallary(
      {this.id,
      this.name,
      this.extension,
      this.userId,
      this.createdBy,
      this.updatedBy,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Gallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    extension = json['extension'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'] == null ? "Null" : json['deleted_at'];
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
    isDefault = json['is_default'];
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

class Stock {
  int productId;
  Null productCombinationId;
  String productType;
  int warehouseId;
  String stockIn;
  String stockOut;
  String remainingStock;
  int price;
  Null discountPrice;

  Stock(
      {this.productId,
      this.productCombinationId,
      this.productType,
      this.warehouseId,
      this.stockIn,
      this.stockOut,
      this.remainingStock,
      this.price,
      this.discountPrice});

  Stock.fromJson(Map<String, dynamic> json) {
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
