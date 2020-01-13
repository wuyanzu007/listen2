import 'package:json_annotation/json_annotation.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/models/singer_model.dart';
import 'album_model.dart';

part 'music_model.g.dart';

@JsonSerializable()
class MusicModel {
  String id;
  String picUrl;
  String playUrl;
  String name;
  SingerModel singer;
  AlbumModel album;
  PlatformsEnum platform;

  MusicModel(
      {this.id,
      this.picUrl,
      this.playUrl,
      this.name,
      this.singer,
      this.album,
      this.platform});

  factory MusicModel.fromJson(Map<String, dynamic> json) =>
      _$MusicModelFromJson(json);

  Map<String, dynamic> toJson() => _$MusicModelToJson(this);
}
