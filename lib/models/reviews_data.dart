class ReviewsData {
  int id;
  Customer customer;
  String comment;
  String rating;
  String status;

  ReviewsData({this.id, this.customer, this.comment, this.rating, this.status});

  ReviewsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    comment = json['comment'];
    rating = json['rating'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['status'] = this.status;
    return data;
  }
}

class Customer {
  int customerId;
  String customerFirstName;
  String customerLastName;
  String customerEmail;
  String customerHash;
  String isSeen;
  String customerStatus;

  Customer(
      {this.customerId,
        this.customerFirstName,
        this.customerLastName,
        this.customerEmail,
        this.customerHash,
        this.isSeen,
        this.customerStatus});

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    customerEmail = json['customer_email'];
    customerHash = json['customer_hash'];
    isSeen = json['is_seen'];
    customerStatus = json['customer_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_first_name'] = this.customerFirstName;
    data['customer_last_name'] = this.customerLastName;
    data['customer_email'] = this.customerEmail;
    data['customer_hash'] = this.customerHash;
    data['is_seen'] = this.isSeen;
    data['customer_status'] = this.customerStatus;
    return data;
  }
}
