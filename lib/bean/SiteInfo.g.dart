// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SiteInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteInfo _$SiteInfoFromJson(Map<String, dynamic> json) {
  return SiteInfo(
      json['cat_cn'] as String,
      json['cat_en'] as String,
      json['desc'] as String,
      json['feed_id'] as String,
      json['icon'] as String,
      json['id'] as String,
      json['name'] as String,
      json['subscribers'] as int,
      json['type'] as String,
      json['url'] as String);
}

Map<String, dynamic> _$SiteInfoToJson(SiteInfo instance) => <String, dynamic>{
      'cat_cn': instance.catCn,
      'cat_en': instance.catEn,
      'desc': instance.desc,
      'feed_id': instance.feedId,
      'icon': instance.icon,
      'id': instance.id,
      'name': instance.name,
      'subscribers': instance.subscribers,
      'type': instance.type,
      'url': instance.url
    };
