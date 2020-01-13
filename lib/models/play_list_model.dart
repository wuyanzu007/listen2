import 'package:json_annotation/json_annotation.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/models/music_model.dart';

part 'play_list_model.g.dart';

@JsonSerializable()
class PlayListModel {
  String id;
  String title;
  String imageUrl;
  List<MusicModel> musicList;
  PlatformsEnum platform;

  PlayListModel(
      {this.id, this.title, this.imageUrl, this.musicList, this.platform});

  factory PlayListModel.fromJson(Map<String, dynamic> json) =>
      _$PlayListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayListModelToJson(this);
}
