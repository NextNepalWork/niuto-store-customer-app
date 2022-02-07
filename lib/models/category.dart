class Category {
  int id;
  String name;
  String desc;
  String icon;
  String gallary;
  int parent;

  Category({this.id, this.name, this.desc, this.icon, this.gallary, this.parent});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    icon = json['icon'];
    gallary = json['gallary'];
    parent = json['parent'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['icon'] = this.icon;
    data['gallary'] = this.gallary;
    data['parent'] = this.parent;
    return data;
  }
}