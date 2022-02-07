class AddressData {
  int id;
  AddressCustomer customer;
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

  AddressData(
      {this.id,
      this.customer,
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

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? new AddressCustomer.fromJson(json['customer'])
        : null;
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
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
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

class AddressCustomer {
  int customerId;
  String customerFirstName;
  String customerLastName;
  String customerEmail;
  String customerHash;
  String isSeen;
  String customerStatus;

  AddressCustomer(
      {this.customerId,
      this.customerFirstName,
      this.customerLastName,
      this.customerEmail,
      this.customerHash,
      this.isSeen,
      this.customerStatus});

  AddressCustomer.fromJson(Map<String, dynamic> json) {
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
