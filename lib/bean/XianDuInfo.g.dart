// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'XianDuInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XianDuInfo _$XianDuInfoFromJson(Map<String, dynamic> json) {
  return XianDuInfo(
      json['content'] as String,
      json['cover'] as String,
      json['created_at'] as String,
      json['published_at'] as String,
      json['title'] as String,
      json['uid'] as String,
      json['url'] as String)
    ..site = json['site'] == null
        ? null
        : SiteInfo.fromJson(json['site'] as Map<String, dynamic>);
}

Map<String, dynamic> _$XianDuInfoToJson(XianDuInfo instance) =>
    <String, dynamic>{
      'content': instance.content,
      'cover': instance.cover,
      'created_at': instance.createdAt,
      'published_at': instance.publishedAt,
      'title': instance.title,
      'uid': instance.uid,
      'url': instance.url,
      'site': instance.site
    };
