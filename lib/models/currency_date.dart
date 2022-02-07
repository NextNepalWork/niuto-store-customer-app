class CurrencyData {
  int currencyId;
  String title;
  String code;
  String symbolPosition;
  String value;
  var exchangeRate;
  int decimalPoint;
  Null thousandPoint;
  String decimalPlace;
  int isDefault;
  String status;
  CountryId countryId;

  CurrencyData(
      {this.currencyId,
      this.title,
      this.code,
      this.symbolPosition,
      this.value,
      this.exchangeRate,
      this.decimalPoint,
      this.thousandPoint,
      this.decimalPlace,
      this.isDefault,
      this.status,
      this.countryId});

  CurrencyData.fromJson(Map<String, dynamic> json) {
    currencyId = json['currency_id'];
    title = json['title'];
    code = json['code'];
    symbolPosition = json['symbol_position'];
    value = json['value'];
    exchangeRate = json['exchange_rate'];
    decimalPoint = int.parse(json['decimal_point']);
    thousandPoint = json['thousand_point'];
    decimalPlace = json['decimal_place'];
    isDefault = int.parse(json['is_default']);
    status = json['status'];
    countryId = json['country_id'] != null
        ? new CountryId.fromJson(json['country_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_id'] = this.currencyId;
    data['title'] = this.title;
    data['code'] = this.code;
    data['symbol_position'] = this.symbolPosition;
    data['value'] = this.value;
    data['exchange_rate'] = this.exchangeRate;
    data['decimal_point'] = this.decimalPoint;
    data['thousand_point'] = this.thousandPoint;
    data['decimal_place'] = this.decimalPlace;
    data['is_default'] = this.isDefault;
    data['status'] = this.status;
    if (this.countryId != null) {
      data['country_id'] = this.countryId.toJson();
    }
    return data;
  }
}

class CountryId {
  int id;
  String name;
  String isoCode2;
  String isoCode3;
  String addressFormatId;
  Null countryCode;
  Null deletedAt;
  Null createdAt;
  Null updatedAt;

  CountryId(
      {this.id,
      this.name,
      this.isoCode2,
      this.isoCode3,
      this.addressFormatId,
      this.countryCode,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  CountryId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isoCode2 = json['iso_code_2'];
    isoCode3 = json['iso_code_3'];
    addressFormatId = json['address_format_id'];
    countryCode = json['country_code'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['iso_code_2'] = this.isoCode2;
    data['iso_code_3'] = this.isoCode3;
    data['address_format_id'] = this.addressFormatId;
    data['country_code'] = this.countryCode;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String first;
  String last;
  Null prev;
  Null next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Links> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      // links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
