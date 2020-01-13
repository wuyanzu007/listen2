import 'package:json_annotation/json_annotation.dart';
import 'package:listen2/common/enums.dart';

part 'album_model.g.dart';

@JsonSerializable()
class AlbumModel {
  String id;
  String name;
  String picUrl;
  PlatformsEnum platform;

  AlbumModel({this.id, this.name, this.picUrl, this.platform});

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);
}
