class PageData {
  int id;
  String slug;
  List<Detail> detail;

  PageData({this.id, this.slug, this.detail});

  PageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    if (json['detail'] != null) {
      detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String title;
  String description;
  Language language;

  Detail({this.title, this.description, this.language});

  Detail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    return data;
  }
}

class Language {
  int id;
  String languageName;
  String code;
  int isDefault;
  String direction;
  Null directory;

  Language(
      {this.id,
      this.languageName,
      this.code,
      this.isDefault,
      this.direction,
      this.directory});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageName = json['language_name'];
    code = json['code'];
    isDefault = int.parse(json['is_default']);
    direction = json['direction'];
    directory = json['directory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language_name'] = this.languageName;
    data['code'] = this.code;
    data['is_default'] = this.isDefault;
    data['direction'] = this.direction;
    data['directory'] = this.directory;
    return data;
  }
}
