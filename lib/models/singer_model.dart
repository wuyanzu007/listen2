import 'package:json_annotation/json_annotation.dart';
import 'package:listen2/common/enums.dart';

part 'singer_model.g.dart';

@JsonSerializable()
class SingerModel {
  String id;
  String name;
  String iconUrl;
  PlatformsEnum platform;

  SingerModel({this.id, this.name, this.iconUrl,this.platform});

  factory SingerModel.fromJson(Map<String, dynamic> json) =>
      _$SingerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SingerModelToJson(this);
}
