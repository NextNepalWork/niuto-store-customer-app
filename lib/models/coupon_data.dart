class CouponData {
  String couponCode;
  String description;
  var amount;
  String type;

  CouponData(
      {this.couponCode,
        this.description,
        this.amount,
        this.type});

  CouponData.fromJson(Map<String, dynamic> json) {
    couponCode = json['coupon_code'];
    description = json['description'];
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_code'] = this.couponCode;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['type'] = this.type;
    return data;
  }
}
