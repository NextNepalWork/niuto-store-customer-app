import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/coupon_data.dart';

class CouponResponse {
  CouponData data;
  String status;
  String message;
  int statusCode;

  CouponResponse({this.data, this.status, this.message, this.statusCode});

  CouponResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CouponData.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  CouponResponse.withError(String error) {
    data = null;
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}