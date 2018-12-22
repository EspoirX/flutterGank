import 'package:json_annotation/json_annotation.dart';

part 'TodayGank.g.dart';

@JsonSerializable()
class TodayGank {
  String id;
  String createdAt;
  String desc;
  List<String> images;
  String publishedAt;
  String source;
  String type;
  String url;
  String who;

  TodayGank(this.id, this.createdAt, this.desc, this.images, this.publishedAt,
      this.source, this.type, this.url, this.who);

  factory TodayGank.fromJson(Map<String, dynamic> json) =>
      _$TodayGankFromJson(json);

  Map<String, dynamic> toJson() => _$TodayGankToJson(this);

  @override
  String toString() {
    return 'TodayGank{id: $id}';
  }


}
