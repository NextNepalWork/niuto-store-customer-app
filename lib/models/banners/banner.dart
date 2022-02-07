import 'banner_navigation.dart';

class BannerData {
  int bannerId;
  String bannerTitle;
  String bannerDescription;
  int bannerRefId;
  String bannerStatus;
  BannerNavigation bannerNavigation;
  String gallary;
  int language;

  BannerData(
      {this.bannerId,
      this.bannerTitle,
      this.bannerDescription,
      this.bannerRefId,
      this.bannerStatus,
      this.bannerNavigation,
      this.gallary,
      this.language});

  BannerData.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerTitle = json['banner_title'];
    bannerDescription = json['banner_description'];
    bannerRefId = int.parse(json['banner_ref_id']);
    bannerStatus = json['banner_status'];
    bannerNavigation = json['banner_navigation'] != null
        ? new BannerNavigation.fromJson(json['banner_navigation'])
        : null;
    gallary = json['gallary'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerId;
    data['banner_title'] = this.bannerTitle;
    data['banner_description'] = this.bannerDescription;
    data['banner_ref_id'] = this.bannerRefId;
    data['banner_status'] = this.bannerStatus;
    if (this.bannerNavigation != null) {
      data['banner_navigation'] = this.bannerNavigation.toJson();
    }
    data['gallary'] = this.gallary;
    data['language'] = this.language;
    return data;
  }
}
