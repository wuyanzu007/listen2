import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:listen2/api/response/bi_li_bi_li/bi_li_bi_li_get_music_detail_response.dart';
import 'package:listen2/api/response/bi_li_bi_li/bi_li_bi_li_get_play_list_music_response.dart';
import 'package:listen2/api/response/bi_li_bi_li/bi_li_bi_li_get_play_list_response.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/models/album_model.dart';
import 'package:listen2/models/music_model.dart';

import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/models/singer_model.dart';
import 'package:listen2/utils/log_util.dart';

import 'abstract_platform.dart';

class BiLiBiLiApi extends AbstractPlatform {
  Dio _dio;

  static BiLiBiLiApi _biLiBiLiApi;

  BiLiBiLiApi._internal();

  factory BiLiBiLiApi() {
    if (_biLiBiLiApi == null) {
      _biLiBiLiApi = BiLiBiLiApi._internal();
      _biLiBiLiApi.init();
    }
    return _biLiBiLiApi;
  }

  void init() {
    _dio = Dio();
  }

  @override
  Future<List<String>> getHotSearch({Map<String, dynamic> queryParameters}) {
    return null;
  }

  @override
  Future<MusicModel> getMusicDetail({MusicModel param}) async {
    String sid = param.id ?? "";
    String url = "https://www.bilibili.com/audio/music-service-c/web/url";
    var queryParam = {"sid": sid};
    var response = await _dio.get(url, queryParameters: queryParam);
    var biLiBiLiGetMusicDetailResponse =
        BiLiBiLiGetMusicDetailResponse.fromJson(
            json.decode(response.toString()));
    if (biLiBiLiGetMusicDetailResponse != null &&
        biLiBiLiGetMusicDetailResponse.data != null &&
        biLiBiLiGetMusicDetailResponse.data.cdns != null) {
      param.playUrl = biLiBiLiGetMusicDetailResponse.data.cdns[0];
    }
    return param;
  }

  @override
  Future<List<PlayListModel>> getPlayList(
      {Map<String, dynamic> queryParameters}) async {
    int currentPage = queryParameters["page"] ?? 1;
    String url = "https://www.bilibili.com/audio/music-service-c/web/menu/hit";
    var param = {"ps": 20, "pn": currentPage};
    var response = await _dio.get(url, queryParameters: param);
    LogUtil.i(response);
    var biLiBiLiGetPlayListResponse =
        BiLiBiLiGetPlayListResponse.fromJson(json.decode(response.toString()));
    List<PlayListModel> playListModelList = List();
    if (biLiBiLiGetPlayListResponse != null &&
        biLiBiLiGetPlayListResponse.data != null &&
        biLiBiLiGetPlayListResponse.data.data != null) {
      biLiBiLiGetPlayListResponse.data.data.forEach((playList) => {
            playListModelList.add(PlayListModel(
                id: playList.menuId.toString(),
                title: playList.title,
                imageUrl: playList.cover,
                platform: PlatformsEnum.BI_LI_BI_LI))
          });
    }
    return playListModelList;
  }

  @override
  Future<List<MusicModel>> getPlayListMusic(
      {Map<String, dynamic> queryParameters}) async {
    String playListId = queryParameters.containsKey("playListId")
        ? queryParameters["playListId"].toString()
        : "";
    String url =
        "https://www.bilibili.com/audio/music-service-c/web/song/of-menu";
    var param = {"pn": 1, "ps": 100, "sid": playListId};
    var response = await _dio.get(url, queryParameters: param);
    LogUtil.d(response);
    var biLiBiLiGetPlayListMusicResponse =
        BiLiBiLiGetPlayListMusicResponse.fromJson(
            json.decode(response.toString()));
    List<MusicModel> musicModelList = List();
    biLiBiLiGetPlayListMusicResponse.data.data.forEach((song) =>
        musicModelList.add(MusicModel(
            id: song.id.toString(),
            name: song.title,
            picUrl: song.cover,
            platform: PlatformsEnum.BI_LI_BI_LI,
            album: AlbumModel(
                id: "", name: "", platform: PlatformsEnum.BI_LI_BI_LI),
            singer: SingerModel(
                id: song.uid.toString(),
                name: song.uname,
                platform: PlatformsEnum.BI_LI_BI_LI))));
    return musicModelList;
  }

  @override
  Future<List<MusicModel>> search({Map<String, dynamic> queryParameters}) {
    // TODO: implement search
    return null;
  }
}
