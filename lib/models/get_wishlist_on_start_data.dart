class GetWishlistOnStartData {
  int wishlist;
  int productId;
  int customerId;

  GetWishlistOnStartData({this.wishlist, this.productId, this.customerId});

  GetWishlistOnStartData.fromJson(Map<String, dynamic> json) {
    wishlist = json['wishlist'];
    productId = int.parse(json['product_id']);
    customerId = int.parse(json['customer_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wishlist'] = this.wishlist;
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    return data;
  }
}
