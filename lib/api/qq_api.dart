import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:listen2/api/abstract_platform.dart';
import 'package:listen2/api/response/qq/qq_get_play_list_music_response.dart';
import 'package:listen2/api/response/qq/qq_get_play_list_response.dart';
import 'package:listen2/api/response/qq/qq_get_play_url_response.dart';
import 'package:listen2/api/response/qq/qq_hot_search_response.dart';
import 'package:listen2/api/response/qq/qq_search_response.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/models/album_model.dart';
import 'package:listen2/models/music_model.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/models/singer_model.dart';
import 'package:listen2/utils/log_util.dart';
import 'package:http/http.dart' as http;

class QQApi extends AbstractPlatform {
  Dio _dio;

  static QQApi _qqApi;

  QQApi._internal();

  factory QQApi() {
    if (_qqApi == null) {
      _qqApi = QQApi._internal();
      _qqApi.init();
    }
    return _qqApi;
  }

  void init() {
    _dio = Dio();
  }

  @override
  Future<List<String>> getHotSearch(
      {Map<String, dynamic> queryParameters}) async {
    String url = "https://c.y.qq.com/splcloud/fcgi-bin/gethotkey.fcg";
    var param = {
      "g_tk": 5381,
      "loginUin": 0,
      "hostUin": 0,
      "format": "json",
      "inCharset": "utf8",
      "outCharset": "utf-8",
      "notice": 0,
      "platform": "yqq.json",
      "needNewCode": 0
    };
    var response = await _dio.get(url, queryParameters: param);
    QQHotSearchResult qqHotSearchResult =
        QQHotSearchResult.fromJson(json.decode(response.toString()));
    var list = qqHotSearchResult.data.hotkey.map((hotKey) => hotKey.k).toList();
    return list;
  }

  @override
  Future<MusicModel> getMusicDetail({MusicModel param}) async {
    String songId = param.id ?? "1404906595";
    String url = await _getPlayUrl(songId);
    param.playUrl = url;
    param.picUrl = _getPicUrl(param);
    LogUtil.e(param.picUrl);
    return param;
  }

  String _getPicUrl(MusicModel param) {
    if (param == null || param.album == null || param.album.id.isEmpty) {
      return "";
    }
    return "http://imgcache.qq.com/music/photo/mid_album_300/" +
        param.album.id[param.album.id.length - 2] +
        "/" +
        param.album.id[param.album.id.length - 1] +
        "/" +
        param.album.id +
        ".jpg";
  }

  Future<String> _getPlayUrl(String songId) async {
    String url = "https://u.y.qq.com/cgi-bin/musicu.fcg";
    Map<String, dynamic> paramMap = new Map();
    paramMap["loginUin"] = 0;
    paramMap["hostUin"] = 0;
    paramMap["format"] = "json";
    paramMap["inCharset"] = "utf8";
    paramMap["outCharset"] = "utf-8";
    paramMap["notice"] = 0;
    paramMap["platform"] = "yqq.json";
    paramMap["needNewCode"] = 0;
    paramMap["data"] =
        '{"req_0":{"module":"vkey.GetVkeyServer","method":"CgiGetVkey","param":{"guid":"8837571570","songmid":["$songId"],"songtype":[0],"uin":"1098924157","loginflag":1,"platform":"20"}},"comm":{"uin":1098924157,"format":"json","ct":24,"cv":0}}';
    var paramUrl = generateUrl(url, paramMap);
    var response = await http.get(paramUrl);
    String jsonResponse = utf8.decode(response.bodyBytes);
    QQGetPlayUrlResponse qqGetPlayUrlResponse =
        QQGetPlayUrlResponse.fromJson(json.decode(jsonResponse));
    return qqGetPlayUrlResponse.req0.data.sip[0] +
        qqGetPlayUrlResponse.req0.data.midurlinfo[0].purl;
  }

  String generateUrl(String url, Map paramMap) {
    if (paramMap.isEmpty) {
      return url;
    }
    url += "?";
    paramMap.forEach(
        (key, v) => {url = url + key.toString() + "=" + v.toString() + "&"});
    return url;
  }

  @override
  Future<List<PlayListModel>> getPlayList(
      {Map<String, dynamic> queryParameters}) async {
    int currentPage = queryParameters["page"] ?? 1;
    String url = "https://c.y.qq.com/splcloud/fcgi-bin/fcg_get_diss_by_tag.fcg";
    Map<String, dynamic> paramMap = new Map();
    paramMap["picmid"] = 1;
    paramMap["rnd"] = "0.5388897880247634";
    paramMap["g_tk"] = 538111;
    paramMap["loginUin"] = 0;
    paramMap["hostUin"] = 0;
    paramMap["format"] = "json";
    paramMap["inCharset"] = "utf8";
    paramMap["outCharset"] = "utf-8";
    paramMap["notice"] = 0;
    paramMap["platform"] = "yqq.json";
    paramMap["needNewCode"] = 0;
    paramMap["categoryId"] = 10000000;
    paramMap["sortId"] = 5;
    paramMap["sin"] = (currentPage - 1) * 30;
    paramMap["ein"] = currentPage * 30 - 1;
    var headers = {
      "Referer": "https://y.qq.com/portal/playlist.html",
      "Sec-Fetch-Dest": "empty",
      "User-Agent":
          "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36"
    };
    var response = await _dio.get(url,
        queryParameters: paramMap, options: Options(headers: headers));
    QQGetPlayListResponse qqGetPlayListResponse =
        QQGetPlayListResponse.fromJson(jsonDecode(response.toString()));
    List<PlayListModel> playListModelList = new List();
    qqGetPlayListResponse.data.list.forEach((model) {
      PlayListModel playListModel = PlayListModel(
          platform: PlatformsEnum.QQ,
          title: model.dissname,
          imageUrl: model.imgurl,
          id: model.dissid);
      playListModelList.add(playListModel);
    });
    return playListModelList;
  }

  @override
  Future<List<MusicModel>> getPlayListMusic(
      {Map<String, dynamic> queryParameters}) async {
    String playListId = queryParameters["playListId"] ?? 0;
    String url =
        "http://i.y.qq.com/qzone-music/fcg-bin/fcg_ucc_getcdinfo_byids_cp.fcg";
    Map<String, dynamic> paramMap = new Map();
    paramMap["type"] = 1;
    paramMap["json"] = 1;
    paramMap["utf8"] = 1;
    paramMap["onlysong"] = 0;
    paramMap["nosign"] = 1;
    paramMap["disstid"] = playListId;
    paramMap["g_tk"] = 5381;
    paramMap["loginUin"] = 0;
    paramMap["hostUin"] = 0;
    paramMap["format"] = "json";
    paramMap["inCharset"] = "GB2312";
    paramMap["outCharset"] = "utf-8";
    paramMap["notice"] = 0;
    paramMap["platform"] = "yqq";
    paramMap["needNewCode"] = 0;
    var headers = {
      "referer": "https://y.qq.com/n/yqq/playlist/$playListId.html",
    };
    Response response = await _dio.get(url,
        queryParameters: paramMap, options: Options(headers: headers));
    LogUtil.i("QQ 获取歌单歌曲信息响应结果:");
    LogUtil.i(response);
    QQGetPlayListMusicResponse qqGetPlayListMusicResponse =
        QQGetPlayListMusicResponse.fromJson(response.data);
    List<MusicModel> musicList = new List();
    for (var music in qqGetPlayListMusicResponse.cdlist[0].songlist) {
      MusicModel musicModel = MusicModel(
          id: music.songmid == null ? "" : music.songmid.toString(),
          name: music.songname,
          picUrl: "",
          singer: SingerModel(
              id: music.singer[0] == null ? "" : music.singer[0].id.toString(),
              name: music.singer[0].name,
              platform: PlatformsEnum.QQ),
          album: AlbumModel(
              id: music.albummid == null ? "" : music.albummid.toString(),
              name: music.albumname,
              platform: PlatformsEnum.QQ),
          platform: PlatformsEnum.QQ);
      musicList.add(musicModel);
    }
    return musicList;
  }

  @override
  Future<List<MusicModel>> search(
      {Map<String, dynamic> queryParameters}) async {
    String keywords = queryParameters["queryStr"] ?? "";
    int currentPage = queryParameters["currentPage"] ?? 1;
    String url = "http://i.y.qq.com/s.music/fcgi-bin/search_for_qq_cp";
    var param = {
      "g_tk": 938407465,
      "uin": 0,
      "format": "jsonp",
      "inCharset": "utf-8",
      "outCharset": "utf-8",
      "notice": 0,
      "platform": "h5",
      "needNewCode": 1,
      "w": keywords,
      "zhidaqu": 1,
      "catZhida": 1,
      "t": 0,
      "flag": 1,
      "ie": "utf-8",
      "sem": 1,
      "aggr": 0,
      "perpage": 20,
      "n": 20,
      "p": currentPage,
      "remoteplace": "txt.mqq.all",
      "_": "1459991037831",
      "jsonpCallback": "jsonp4"
    };
    var response = await _dio.get(url,
        queryParameters: param,
        options: Options(headers: {
          "referer": "https://y.qq.com",
        }));
    var responseJson = response
        .toString()
        .substring("jsonp4(".length, response.toString().length - 1);
    var qqSearchResponse =
        QQSearchResponse.fromJson(json.decode(responseJson.toString()));
    List<MusicModel> musicModelList = List();
    for (var song in qqSearchResponse.data.song.list) {
      var musicModel = MusicModel(
          id: song.songmid,
          name: song.songname,
          platform: PlatformsEnum.QQ,
          album: AlbumModel(
              id: song.albummid,
              name: song.albumname,
              platform: PlatformsEnum.QQ),
          singer: SingerModel(
              id: song.singer[0].mid,
              name: song.singer[0].name,
              platform: PlatformsEnum.QQ));
      String picUrl = _getPicUrl(musicModel);
      musicModel.picUrl = picUrl;
      musicModelList.add(musicModel);
    }
    return musicModelList;
  }
}
