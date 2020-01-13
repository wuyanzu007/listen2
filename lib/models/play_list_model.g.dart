// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayListModel _$PlayListModelFromJson(Map<String, dynamic> json) {
  return PlayListModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      musicList: (json['musicList'] as List)
          ?.map((e) =>
              e == null ? null : MusicModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      platform: _$enumDecodeNullable(_$PlatformsEnumEnumMap, json['platform']));
}

Map<String, dynamic> _$PlayListModelToJson(PlayListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'musicList': instance.musicList,
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
