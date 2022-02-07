import 'package:flutter_kundol/models/products/product.dart';

class WishlistDetailData {
  int wishlist;
  Product products;
  int productId;
  int customerId;

  WishlistDetailData(
      {this.wishlist, this.products, this.productId, this.customerId});

  WishlistDetailData.fromJson(Map<String, dynamic> json) {
    wishlist = json['wishlist'];
    products = json['products'] != null
        ? new Product.fromJson(json['products'])
        : null;
    productId = int.parse(json['product_id']);
    customerId = int.parse(json['customer_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wishlist'] = this.wishlist;
    if (this.products != null) {
      data['products'] = this.products.toJson();
    }
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    return data;
  }
}
