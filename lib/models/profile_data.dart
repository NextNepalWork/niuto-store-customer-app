class ProfileData {
  int customerId;
  String customerFirstName;
  String customerLastName;
  String customerEmail;

  ProfileData(
      {this.customerId,
        this.customerFirstName,
        this.customerLastName,
        this.customerEmail});

  ProfileData.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    customerEmail = json['customer_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_first_name'] = this.customerFirstName;
    data['customer_last_name'] = this.customerLastName;
    data['customer_email'] = this.customerEmail;
    return data;
  }
}

