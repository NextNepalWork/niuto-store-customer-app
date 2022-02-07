class RewardPoint {
  int id;
  int referenceId;
  var points;
  String description;
  int customerId;
  CustomerDetail customerDetail;

  RewardPoint(
      {this.id,
      this.referenceId,
      this.points,
      this.description,
      this.customerId,
      this.customerDetail});

  RewardPoint.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = int.parse(json['reference_id']);
    points = json['points'];
    description = json['description'];
    customerId = int.parse(json['customer_id']);
    customerDetail = json['customer_detail'] != null
        ? new CustomerDetail.fromJson(json['customer_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_id'] = this.referenceId;
    data['points'] = this.points;
    data['description'] = this.description;
    data['customer_id'] = this.customerId;
    if (this.customerDetail != null) {
      data['customer_detail'] = this.customerDetail.toJson();
    }
    return data;
  }
}

class CustomerDetail {
  int customerId;
  String customerFirstName;
  String customerLastName;
  String customerEmail;
  String customerHash;
  String isSeen;
  String customerStatus;
  List<CustomerAddress> customerAddress;

  CustomerDetail(
      {this.customerId,
      this.customerFirstName,
      this.customerLastName,
      this.customerEmail,
      this.customerHash,
      this.isSeen,
      this.customerStatus,
      this.customerAddress});

  CustomerDetail.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    customerEmail = json['customer_email'];
    customerHash = json['customer_hash'];
    isSeen = json['is_seen'];
    customerStatus = json['customer_status'];
    if (json['customer_address'] != null) {
      // customerAddress = new List<CustomerAddress>();
      json['customer_address'].forEach((v) {
        customerAddress.add(new CustomerAddress.fromJson(v));
      });
    }
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
    if (this.customerAddress != null) {
      data['customer_address'] =
          this.customerAddress.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerAddress {
  int id;
  String gender;
  String company;
  String streetAddress;
  String suburb;
  String phone;
  String postcode;
  String dob;
  String city;
  CountryId countryId;
  StateId stateId;
  String lattitude;
  String longitude;
  int defaultAddress;

  CustomerAddress(
      {this.id,
      this.gender,
      this.company,
      this.streetAddress,
      this.suburb,
      this.phone,
      this.postcode,
      this.dob,
      this.city,
      this.countryId,
      this.stateId,
      this.lattitude,
      this.longitude,
      this.defaultAddress});

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    company = json['company'];
    streetAddress = json['street_address'];
    suburb = json['suburb'];
    phone = json['phone'];
    postcode = json['postcode'];
    dob = json['dob'];
    city = json['city'];
    countryId = json['country_id'] != null
        ? new CountryId.fromJson(json['country_id'])
        : null;
    stateId = json['state_id'] != null
        ? new StateId.fromJson(json['state_id'])
        : null;
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    defaultAddress = int.parse(json['default_address']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gender'] = this.gender;
    data['company'] = this.company;
    data['street_address'] = this.streetAddress;
    data['suburb'] = this.suburb;
    data['phone'] = this.phone;
    data['postcode'] = this.postcode;
    data['dob'] = this.dob;
    data['city'] = this.city;
    if (this.countryId != null) {
      data['country_id'] = this.countryId.toJson();
    }
    if (this.stateId != null) {
      data['state_id'] = this.stateId.toJson();
    }
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['default_address'] = this.defaultAddress;
    return data;
  }
}

class CountryId {
  int countryId;
  String countryName;

  CountryId({this.countryId, this.countryName});

  CountryId.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    return data;
  }
}

class StateId {
  int id;
  String name;
  int countryId;

  StateId({this.id, this.name, this.countryId});

  StateId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = int.parse(json['country_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    return data;
  }
}
