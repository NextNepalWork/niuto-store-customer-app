class SettingsObj {
  String settingKey;
  String settingValue;
  String settingType;

  SettingsObj({this.settingKey, this.settingValue, this.settingType});

  SettingsObj.fromJson(Map<String, dynamic> json) {
    settingKey = json['setting_key'];
    settingValue = json['setting_value'];
    settingType = json['setting_type'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['setting_key'] = this.settingKey;
    data['setting_value'] = this.settingValue;
    data['setting_type'] = this.settingType;
    return data;
  }
}