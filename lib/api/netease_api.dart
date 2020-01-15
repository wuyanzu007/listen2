import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:listen2/api/abstract_platform.dart';
import 'package:listen2/api/response/netease/netease_get_hot_search_response.dart';
import 'package:listen2/api/response/netease/netease_get_music_detail_response.dart';
import 'package:listen2/api/response/netease/netease_get_music_url_response.dart';
import 'package:listen2/api/response/netease/netease_get_music_list_detail_response.dart';
import 'package:listen2/api/response/netease/netease_search_response.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/models/album_model.dart';
import 'package:listen2/models/music_model.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/models/singer_model.dart';

class NeteaseApi extends AbstractPlatform {
  Options _options;
  Dio _dio;

  static NeteaseApi _neteaseApi;

  NeteaseApi._internal();

  factory NeteaseApi() {
    if (_neteaseApi == null) {
      _neteaseApi = NeteaseApi._internal();
      _neteaseApi.init();
    }
    return _neteaseApi;
  }

  void init() {
    _dio = Dio();
  }

  @override
  Future<List<String>> getHotSearch(
      {Map<String, dynamic> queryParameters}) async {
    String url = "https://music.163.com/weapi/search/hot";
    var paramData = {"type": 1111};
    const channel = const MethodChannel("com.wuyanzu007.listen2/encrypt");
    Map result = await channel
        .invokeMethod("encryptNeteaseParam", {"param": json.encode(paramData)});
    var response = await _dio.post(url,
        queryParameters: {
          "params": result["params"],
          "encSecKey": result["encSecKey"]
        },
        options: new Options(
            headers: {"Content-Type": "application/x-www-form-urlencoded"}));
    var neteaseGetHotSearchResponse =
        NeteaseGetHotSearchResponse.fromJson(json.decode(response.toString()));
    List<String> hotSearch = List();
    if (neteaseGetHotSearchResponse != null &&
        neteaseGetHotSearchResponse.result != null &&
        neteaseGetHotSearchResponse.result.hots != null) {
      neteaseGetHotSearchResponse.result.hots
          .forEach((hot) => hotSearch.add(hot.first));
    }
    return hotSearch;
  }

  @override
  Future<List<PlayListModel>> getPlayList(
      {Map<String, dynamic> queryParameters}) async {
    String url = "http://music.163.com/discover/playlist/";
    Map<String, dynamic> paramMap = new Map();
    int currentPage = queryParameters["page"] ?? 0;
    paramMap["order"] = "hot";
    paramMap["limit"] = 35;
    paramMap["offset"] = currentPage * 35;
    Response response =
        await _dio.get(url, queryParameters: paramMap, options: _options);
    List<PlayListModel> playListModelList = new List();
    var document = parse(response.toString());
    var ul = document.getElementById("m-pl-container");
    List<dom.Element> liList = ul.children;
    for (dom.Element li in liList) {
      PlayListModel playListModel = new PlayListModel();
      playListModel.platform = PlatformsEnum.NETEASE;
      var imgTag = li.getElementsByClassName("j-flag").first;
      playListModel.imageUrl = imgTag.attributes["src"].toString();
      var titleATag = li.getElementsByClassName("tit f-thide s-fc0").first;
      playListModel.title = titleATag.attributes["title"].toString();
      String href = titleATag.attributes["href"].toString();
      playListModel.id = href.split("?")[1].substring(3);
      playListModelList.add(playListModel);
    }
    return playListModelList;
  }

  @override
  Future<List<MusicModel>> getPlayListMusic(
      {Map<String, dynamic> queryParameters}) async {
    String url = "http://music.163.com/weapi/v3/playlist/detail";
    String playListId = queryParameters["playListId"] ?? 0;
    var param = {
      "id": playListId,
      "offset": 0,
      "total": true,
      "limit": 1000,
      "n": 1000,
      "csrf_token": ""
    };
    String jsonParam = json.encode(param);
    const channel = const MethodChannel("com.wuyanzu007.listen2/encrypt");
    Map result =
        await channel.invokeMethod("encryptNeteaseParam", {"param": jsonParam});
    var response = await _dio.post(url,
        queryParameters: {
          "params": result["params"],
          "encSecKey": result["encSecKey"]
        },
        options: new Options(
            headers: {"Content-Type": "application/x-www-form-urlencoded"}));

    var getMusicListDetailResult = NeteaseGetMusicListDetailResponse.fromJson(
        json.decode(response.toString()));
    List<MusicModel> musicModelList = new List();
    for (var track in getMusicListDetailResult.playlist.tracks) {
      MusicModel musicModel = new MusicModel(
          name: track.name,
          id: track.id.toString(),
          picUrl: track.al.picUrl,
          singer: SingerModel(
              name: track.ar[0].name,
              id: track.ar[0].id.toString(),
              platform: PlatformsEnum.NETEASE),
          album: AlbumModel(
              name: track.al.name,
              id: track.al.id.toString(),
              picUrl: track.al.picUrl,
              platform: PlatformsEnum.NETEASE),
          platform: PlatformsEnum.NETEASE);
      musicModelList.add(musicModel);
    }
    return musicModelList;
  }

  @override
  Future<MusicModel> getMusicDetail({MusicModel param}) async {
    String songId = param.id ?? "1404906595";
    String url = "https://music.163.com/weapi/v3/song/detail?csrf_token=";
    var paramMap = {"c": '[{"id":$songId}]', "ids": "[$songId]"};
    String jsonParam = json.encode(paramMap);
    const channel = const MethodChannel("com.wuyanzu007.listen2/encrypt");
    Map result =
        await channel.invokeMethod("encryptNeteaseParam", {"param": jsonParam});
    var response = await _dio.post(url,
        queryParameters: {
          "params": result["params"],
          "encSecKey": result["encSecKey"]
        },
        options: new Options(
            headers: {"Content-Type": "application/x-www-form-urlencoded"}));
    var neteaseGetMusicDetailResult = NeteaseGetMusicDetailResponse.fromJson(
        json.decode(response.toString()));
    if (neteaseGetMusicDetailResult.code == 200) {
      MusicModel musicModel = new MusicModel(
          picUrl: neteaseGetMusicDetailResult.songs[0].al.picUrl,
          playUrl: await _getPlayUrl(songId),
          platform: PlatformsEnum.NETEASE);
      return musicModel;
    }
    Fluttertoast.showToast(msg: "获取歌曲失败");
    return null;
  }

  Future<String> _getPlayUrl(String songId) async {
    String url =
        "http://music.163.com/weapi/song/enhance/player/url/v1?csrf_token=";
    var param = {
      "ids": [songId],
      "level": "standard",
      "encodeType": "aac",
      "csrf_token": ""
    };
    String jsonParam = json.encode(param);
    const channel = const MethodChannel("com.wuyanzu007.listen2/encrypt");
    Map result =
        await channel.invokeMethod("encryptNeteaseParam", {"param": jsonParam});
    var response = await _dio.post(url,
        queryParameters: {
          "params": result["params"],
          "encSecKey": result["encSecKey"]
        },
        options: new Options(
            headers: {"Content-Type": "application/x-www-form-urlencoded"}));
    NeteaseGetMusicUrlResponse neteaseGetMusicDetailResult =
        NeteaseGetMusicUrlResponse.fromJson(json.decode(response.toString()));
    if (neteaseGetMusicDetailResult.code == 200) {
      return neteaseGetMusicDetailResult.data[0].url ?? "";
    }
    return "";
  }

  @override
  Future<List<MusicModel>> search(
      {Map<String, dynamic> queryParameters}) async {
    String keywords = queryParameters["queryStr"] ?? "";
    int currentPage = queryParameters["currentPage"] ?? 1;
    String url = "http://music.163.com/api/search/pc";
    var reqData = {
      "s": keywords,
      "offset": 20 * (currentPage - 1),
      "limit": 20,
      "type": 1
    };
    var response = await _dio.post(url, queryParameters: reqData);
    NeteaseSearchResponse neteaseSearchResponse =
        NeteaseSearchResponse.fromJson(json.decode(response.toString()));
    List<MusicModel> musicModelList = new List();
    if (neteaseSearchResponse != null &&
        neteaseSearchResponse.result != null &&
        neteaseSearchResponse.result.songs != null) {
      neteaseSearchResponse.result.songs.forEach((song) => {
            musicModelList.add(MusicModel(
                id: song.id.toString(),
                name: song.name,
                platform: PlatformsEnum.NETEASE,
                picUrl: song.album.picUrl,
                album: AlbumModel(
                    id: song.album.id.toString(),
                    name: song.album.name,
                    picUrl: song.album.picUrl,
                    platform: PlatformsEnum.NETEASE),
                singer: SingerModel(
                    id: song.artists[0].id.toString(),
                    name: song.artists[0].name,
                    iconUrl: song.artists[0].picUrl,
                    platform: PlatformsEnum.NETEASE)))
          });
    }
    return musicModelList;
  }
}
