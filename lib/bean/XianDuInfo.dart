import 'package:flutter_gank/bean/SiteInfo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'XianDuInfo.g.dart';
@JsonSerializable()
class XianDuInfo {
  String content;
  String cover;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'published_at')
  String publishedAt;

  String title;
  String uid;
  String url;
  SiteInfo site;


  XianDuInfo(this.content, this.cover,   this.createdAt,
      this.publishedAt,  this.title, this.uid, this.url);

  factory XianDuInfo.fromJson(Map<String, dynamic> json) =>
      _$XianDuInfoFromJson(json);

  Map<String, dynamic> toJson() => _$XianDuInfoToJson(this);
}
