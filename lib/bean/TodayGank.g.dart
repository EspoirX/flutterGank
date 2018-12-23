// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TodayGank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayGank _$TodayGankFromJson(Map<String, dynamic> json) {
  List<String> images = json.containsKey("images")
      ? (json['images'] as List)?.map((e) => e as String)?.toList()
      : new List<String>();
  return TodayGank(
      json['_id'] as String,
      json['createdAt'] as String,
      json['desc'] as String,
      images,
      json['publishedAt'] as String,
      json['source'] as String,
      json['type'] as String,
      json['url'] as String,
      json['who'] as String);
}

Map<String, dynamic> _$TodayGankToJson(TodayGank instance) => <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'desc': instance.desc,
      'images': instance.images,
      'publishedAt': instance.publishedAt,
      'source': instance.source,
      'type': instance.type,
      'url': instance.url,
      'who': instance.who
    };
