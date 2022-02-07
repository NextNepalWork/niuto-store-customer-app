class QuantityData {
  var productId;
  int productCombinationId;
  String productType;
  int warehouseId;
  String stockIn;
  String stockOut;
  String remainingStock;
  int price;
  var discountPrice;

  QuantityData(
      {this.productId,
        this.productCombinationId,
        this.productType,
        this.warehouseId,
        this.stockIn,
        this.stockOut,
        this.remainingStock,
        this.price,
        this.discountPrice});

  QuantityData.fromJson(Map<String, dynamic> json) {
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