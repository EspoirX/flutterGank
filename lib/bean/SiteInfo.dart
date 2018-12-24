import 'package:json_annotation/json_annotation.dart';
part 'SiteInfo.g.dart';
@JsonSerializable()
class SiteInfo {
  @JsonKey(name: 'cat_cn')
  String catCn;
  @JsonKey(name: 'cat_en')
  String catEn;
  String desc;
  @JsonKey(name: 'feed_id')
  String feedId;
  String icon;
  String id;
  String name;
  int subscribers;
  String type;
  String url;

  SiteInfo(this.catCn, this.catEn, this.desc, this.feedId, this.icon, this.id,
      this.name, this.subscribers, this.type, this.url);

  factory SiteInfo.fromJson(Map<String, dynamic> json) =>
      _$SiteInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SiteInfoToJson(this);
}
