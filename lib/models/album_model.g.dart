// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumModel _$AlbumModelFromJson(Map<String, dynamic> json) {
  return AlbumModel(
      id: json['id'] as String,
      name: json['name'] as String,
      picUrl: json['iconUrl'] as String,
      platform: _$enumDecodeNullable(_$PlatformsEnumEnumMap, json['platform']));
}

Map<String, dynamic> _$AlbumModelToJson(AlbumModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconUrl': instance.picUrl,
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
