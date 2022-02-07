import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/user.dart';

class RegisterResponse {
  String status;
  User data;
  String message;

  RegisterResponse({this.status, this.data, this.message});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
    message = json['message'];
  }

  RegisterResponse.withError(String error) {
    status = AppConstants.STATUS_ERROR;
    data = null;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
