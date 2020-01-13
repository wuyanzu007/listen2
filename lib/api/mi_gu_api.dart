import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/services.dart';
import 'package:html/dom.dart' as dom;
import 'package:listen2/api/response/migu/mi_gu_get_pic_url_response.dart';
import 'package:listen2/api/response/migu/mi_gu_get_play_url_response.dart';

import 'package:html/parser.dart' show parse;
import 'package:listen2/api/response/migu/mi_gu_search_response.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/models/album_model.dart';
import 'package:listen2/models/music_model.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/models/singer_model.dart';
import 'package:listen2/utils/log_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'abstract_platform.dart';

class MiGuApi extends AbstractPlatform {
  Options _options;
  String _key;
  String _iv;
  Dio _dio;
  String _secKey;

  static MiGuApi _miGuApi;

  MiGuApi._internal();

  factory MiGuApi() {
    if (_miGuApi == null) {
      _miGuApi = MiGuApi._internal();
      _miGuApi.init();
    }
    return _miGuApi;
  }

  void init() async {
    _dio = Dio(BaseOptions(headers: {
      "Cookie":
          "migu_cookie_id=b5a559e9-f03e-48b0-9b54-fd14263bbdee-n41573031490260; migu_cn_cookie_id=30affed4-b878-4bf4-b7ce-245d6aca7853; player_stop_open=0; addplaylist_has=1; add_play_now=1; audioplayer_open=1; audioplayer_new=0; playlist_change=0; audioplayer_exist=1; WT_FPC=id=2cd9419f11d0e5323261573031491149:lv=1573624283728:ss=1573624160503; playlist_adding=0",
      "origin": "http://music.migu.cn/v3/music/player/audio?from=migu",
      "Referer": "http://music.migu.cn/v3/music/player/audio?from=migu",
      "Host": "music.migu.cn",
      "User-Agent":
          "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36"
    }));

    const channel = const MethodChannel("com.wuyanzu007.listen2/encrypt");
    Map keyAndIV;
    try {
      keyAndIV = await channel.invokeMethod("miGuGenerateKeyAndIV", {
        "secret":
            "4ea5c508a6566e76240543f8feb06fd457777be39549c4016436afda65d2330e"
      });
      _key = keyAndIV["key"] ?? "sAh9uz/kDngu2Ff2kfniN6nFqUIPlzq3Jg75halV5cQ=";
      _iv = keyAndIV["iv"] ?? "DOZs1vHOGJVMe8UtMpYyrg==";
    } on PlatformException catch (e) {
      LogUtil.e(e.toString());
    }

    _secKey = await _secretRsa();
  }

  Future<String> _paramAes(String plainText) async {
    // 随机salt,此处固定为 "12345678", 需要将salt拼接在加密结果中
    final base64SaltStr = "MTIzNDU2Nzg=";
    // 固定前缀 Salted__
    final base64PrefixStr = "U2FsdGVkX18=";
    final aesEncrypt = Encrypter(
        AES(encrypt.Key.fromBase64(_key), mode: AESMode.cbc, padding: "PKCS7"));
    final encrypted = aesEncrypt.encrypt(plainText, iv: IV.fromBase64(_iv));
    // (加密前缀 + salt + 加密结果)进行base64编码作
    List<int> result = new List();
    result.addAll(base64Decode(base64PrefixStr));
    result.addAll(base64Decode(base64SaltStr));
    result.addAll(encrypted.bytes);
    return base64.encode(result);
  }

  Future<String> _secretRsa() async {
    var dir = await getApplicationDocumentsDirectory();
    var publicKey =
        await parseKeyFromFile<RSAPublicKey>("${dir.path}/migu-public.pem");
    final plainText =
        '4ea5c508a6566e76240543f8feb06fd457777be39549c4016436afda65d2330e';
    final rsaEncrypt = Encrypter(RSA(publicKey: publicKey));
    final encrypted = rsaEncrypt.encrypt(plainText);
    return encrypted.base64;
  }

  @override
  Future<List<PlayListModel>> getPlayList(
      {Map<String, dynamic> queryParameters}) async {
    String url = "http://music.migu.cn/v3/music/playlist";
    Response response = await _dio.get(url,
        queryParameters: queryParameters, options: _options);
    List<PlayListModel> playList = new List();
    var document = parse(response.toString());
    List<dom.Element> itemList = document.getElementsByClassName("thumb");
    for (var thumbDiv in itemList) {
      var musicCoverDiv = thumbDiv.getElementsByClassName("music-cover").first;
      var imageTag = musicCoverDiv.children.first.children.first;
      var songListNameDiv =
          thumbDiv.getElementsByClassName("song-list-name").first;
      var titleTag = songListNameDiv.children.first;
      String href = titleTag.attributes["href"];
      PlayListModel playListModel = new PlayListModel(
          imageUrl: imageTag.attributes["data-original"],
          title: titleTag.attributes["title"],
          id: href.split("/").last,
          platform: PlatformsEnum.MI_GU);
      playList.add(playListModel);
    }
    return playList;
  }

  @override
  Future<List<MusicModel>> getPlayListMusic(
      {Map<String, dynamic> queryParameters}) async {
    List<MusicModel> musicList = new List();
    String url = "http://music.migu.cn/v3/music/playlist/";
    String playListId = queryParameters.containsKey("playListId")
        ? queryParameters["playListId"].toString()
        : "135765874";
    Response response = await _dio.get(url + playListId, options: _options);
    var document = parse(response.toString());
    List<dom.Element> songInfoDivList =
        document.getElementsByClassName("J_CopySong");
    for (var songInfoDiv in songInfoDivList) {
      String title = "",
          href = "",
          id = "",
          imgUrl = "",
          singerName = "",
          singerId = "",
          albumName = "",
          albumId = "";

      var titleTag = songInfoDiv.getElementsByClassName("J_SongName").first;
      if (titleTag.children.length > 0) {
        title = titleTag.children.first.attributes["title"] ?? "";
        href = titleTag.children.first.attributes["href"] ?? "";
        id = href.split("/").last;
      }

      var singerTag = songInfoDiv.getElementsByClassName("J_SongSingers").first;
      if (singerTag.children.length > 0) {
        singerName = singerTag.children.first.text ?? "";
        singerId =
            singerTag.children.first.attributes["href"].split("/").last ?? "";
      }

      var albumTag = songInfoDiv.getElementsByClassName("song-belongs").first;
      if (albumTag.children.length > 0) {
        albumName = albumTag.children.first.text ?? "";
        albumId =
            albumTag.children.first.attributes["href"].split("/").last ?? "";
      }

      var shareButton = songInfoDiv.getElementsByClassName("J-btn-share").first;
      if (shareButton != null) {
        var shareData = shareButton.attributes["data-share"];
        var decode = json.decode(shareData);
        imgUrl = decode == null ? "" : "http:${decode["imgUrl"]}";
      }

      SingerModel singerModel = new SingerModel(
          name: singerName, id: singerId, platform: PlatformsEnum.MI_GU);
      AlbumModel albumModel = new AlbumModel(
          id: albumId, name: albumName, platform: PlatformsEnum.MI_GU);
      MusicModel musicModel = new MusicModel(
          id: id,
          name: title,
          singer: singerModel,
          picUrl: imgUrl,
          album: albumModel,
          platform: PlatformsEnum.MI_GU);
      musicList.add(musicModel);
    }
    return musicList;
  }

  @override
  Future<MusicModel> getMusicDetail({MusicModel param}) async {
    String copyrightId = param.id ?? "6005970MWGB";
    String playUrl = await getPlayUrl(copyrightId);
    String songId = await getSongId(copyrightId);
    String picUrl = await getPicUrl(songId);
    MusicModel musicModel = new MusicModel(
        playUrl: playUrl, picUrl: picUrl, platform: PlatformsEnum.MI_GU);
    return musicModel;
  }

  Future<String> getSongId(String copyrightId) async {
    String url =
        "http://music.migu.cn/v3/api/music/digital_album/checkIsDigitalAlbum";
    var response = await _dio.get(url,
        queryParameters: {"copyrightId": copyrightId}, options: _options);
    Map<String, dynamic> jsonResponse = json.decode(response.toString());
    if (jsonResponse.containsKey("data") && jsonResponse["data"] != null) {
      if (jsonResponse["data"]["songId"] != null) {
        return jsonResponse["data"]["songId"];
      }
    }
    return copyrightId;
  }

  Future<String> getPicUrl(String musicId) async {
    String url = "http://music.migu.cn/v3/api/music/audioPlayer/getSongPic";
    var response = await _dio.get(url,
        queryParameters: {"songId": musicId}, options: _options);
    MiGuGetPicUrlResponse miGuGetPicUrlResult =
        MiGuGetPicUrlResponse.fromJson(json.decode(response.toString()));
    if (miGuGetPicUrlResult.mediumPic != null) {
      return "http:${miGuGetPicUrlResult.mediumPic.toString()}";
    }
    if (miGuGetPicUrlResult.smallPic != null) {
      return "http:${miGuGetPicUrlResult.smallPic.toString()}";
    }
    if (miGuGetPicUrlResult.largePic != null) {
      return "http:${miGuGetPicUrlResult.largePic.toString()}";
    }
    return "http://cdnmusic.migu.cn/picture/2019/1031/0116/AS3f169c1d25854897bed1453a6aead54c.jpg";
  }

  Future<String> getPlayUrl(String copyrightId) async {
    String url = "http://music.migu.cn/v3/api/music/audioPlayer/getPlayInfo";
    String queryParam = '{"copyrightId":"$copyrightId"}';
    var response = await _dio.get(url,
        queryParameters: {
          "dataType": 2,
          "data": await _paramAes(queryParam),
          "secKey": _secKey
        },
        options: _options);
    var getPlayUrlResult =
        MiGuGetPlayUrlResponse.fromJson(json.decode(response.toString()));
    if (getPlayUrlResult.data.sqPlayInfo != null) {
      return getPlayUrlResult.data.sqPlayInfo.playUrl;
    } else if (getPlayUrlResult.data.hqPlayInfo != null) {
      return getPlayUrlResult.data.hqPlayInfo.playUrl;
    } else if (getPlayUrlResult.data.bqPlayInfo != null) {
      return getPlayUrlResult.data.bqPlayInfo.playUrl;
    } else {
      return "";
    }
  }

  @override
  Future<List<String>> getHotSearch(
      {Map<String, dynamic> queryParameters}) async {
    String url = "http://www.migu.cn/searchHotwords";
    var response =
        await _dio.get(url, queryParameters: {"f": "json", "content": 1});
    Map<String, dynamic> jsonResponse = json.decode(response.toString());
    return new List<String>.from(jsonResponse["list"]);
  }

  @override
  Future<List<MusicModel>> search(
      {Map<String, dynamic> queryParameters}) async {
    String url = "http://m.music.migu.cn/migu/remoting/scr_search_tag";
    String keyword = queryParameters["queryStr"] ?? "";
    int pgc = queryParameters["currentPage"] ?? 1;
    var response = await _dio.get(url, queryParameters: {
      "rows": 20,
      "type": 2,
      "keyword": keyword,
      "pgc": pgc
    });
    List<MusicModel> list = new List();
    var searchResult = MiGuSearchResponse.fromJson(response.data);
    if (searchResult != null && searchResult.musics != null) {
      searchResult.musics.forEach((music) {
        SingerModel singerModel = new SingerModel(
            name: music.singerName,
            id: music.singerId,
            platform: PlatformsEnum.MI_GU);
        AlbumModel albumModel = new AlbumModel(
            name: music.albumName,
            id: music.albumId,
            platform: PlatformsEnum.MI_GU);
        MusicModel musicModel = new MusicModel(
            id: music.copyrightId,
            picUrl: music.cover,
            playUrl: music.mp3,
            name: music.title,
            platform: PlatformsEnum.MI_GU,
            singer: singerModel,
            album: albumModel);
        list.add(musicModel);
      });
    }
    return list;
  }
}
