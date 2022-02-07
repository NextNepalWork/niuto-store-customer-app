import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/orders_data.dart';

class OrdersResponse {
  List<OrdersData> data;
  String status;
  String message;
  var statusCode;

  OrdersResponse(
      {this.data,
        this.status,
        this.message,
        this.statusCode});

  OrdersResponse.fromJson(Map<String, dynamic> json) {
  
    if (json['data'] != null) {
      data = new List<OrdersData>();
      json['data'].forEach((v) {
        
        data.add(new OrdersData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  OrdersResponse.withError(String error) {
    data = null;
    statusCode =0;
    status = AppConstants.STATUS_ERROR;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}