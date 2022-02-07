class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String gallaryId;
  String isSeen;
  String status;
  String hash;
  String createdBy;
  String updatedBy;
  String deletedAt;
  String rememberToken;
  String createdAt;
  String updatedAt;
  String token;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.gallaryId,
      this.isSeen,
      this.status,
      this.hash,
      this.createdBy,
      this.updatedBy,
      this.deletedAt,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    gallaryId = json['gallary_id'];
    isSeen = json['is_seen'];
    status = json['status'];
    hash = json['hash'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['gallary_id'] = this.gallaryId;
    data['is_seen'] = this.isSeen;
    data['status'] = this.status;
    data['hash'] = this.hash;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}
