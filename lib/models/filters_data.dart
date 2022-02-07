class FiltersData {
  int attributeId;
  List<Detail> detail;
  List<Variations> variations;

  FiltersData({this.attributeId, this.detail, this.variations});

  FiltersData.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    if (json['detail'] != null) {
      // detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
    if (json['variations'] != null) {
      // variations = new List<Variations>();
      json['variations'].forEach((v) {
        variations.add(new Variations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_id'] = this.attributeId;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    if (this.variations != null) {
      data['variations'] = this.variations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String name;

  Detail({this.name});

  Detail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Variations {
  int id;
  List<Detail> detail;

  Variations({this.id, this.detail});

  Variations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['detail'] != null) {
      // detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
