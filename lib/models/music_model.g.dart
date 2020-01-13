// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicModel _$MusicModelFromJson(Map<String, dynamic> json) {
  return MusicModel(
      id: json['id'] as String,
      picUrl: json['picUrl'] as String,
      playUrl: json['playUrl'] as String,
      name: json['name'] as String,
      singer: json['singer'] == null
          ? null
          : SingerModel.fromJson(json['singer'] as Map<String, dynamic>),
      album: json['album'] == null
          ? null
          : AlbumModel.fromJson(json['album'] as Map<String, dynamic>),
      platform: _$enumDecodeNullable(_$PlatformsEnumEnumMap, json['platform']));
}

Map<String, dynamic> _$MusicModelToJson(MusicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'picUrl': instance.picUrl,
      'playUrl': instance.playUrl,
      'name': instance.name,
      'singer': instance.singer,
      'album': instance.album,
      'platform': _$PlatformsEnumEnumMap[instance.platform]
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$PlatformsEnumEnumMap = <PlatformsEnum, dynamic>{
  PlatformsEnum.MI_GU: 'MI_GU',
  PlatformsEnum.QQ: 'QQ',
  PlatformsEnum.NETEASE: 'NETEASE',
  PlatformsEnum.BI_LI_BI_LI: 'BI_LI_BI_LI'
};
