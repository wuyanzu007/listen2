import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listen2/api/application.dart';
import 'package:listen2/models/music_model.dart';
import 'package:listen2/models/play_list_model.dart';

class MyPlayListProvider with ChangeNotifier {
  Map<String,PlayListModel> _myPlayListMap;

  Map<String,PlayListModel> get myPlayListMap => _myPlayListMap;

  List get myPlayListList => myPlayListMap.values.toList();

  void init() {
    getMyPlayList();
  }

  //保存歌单
  void saveMyPlayList() {
    Application.sp.setString("myPlayListMap", json.encode(_myPlayListMap));
  }

  //初始化我的歌单
  void getMyPlayList() {
    if(Application.sp.get("myPlayListMap") == null){
      return;
    }
    Map<String,dynamic> map = json.decode(Application.sp.get("myPlayListMap"));
    print(map);

    _myPlayListMap = Application.sp.containsKey("myPlayListMap")
        ? json.decode(Application.sp.get("myPlayListMap"))
        : {};
  }

  //添加新歌单
  void addMyPlayList(String name) {
    PlayListModel playListModel = PlayListModel(
        title: name,
        imageUrl:
            "https://y.gtimg.cn/music/photo_new/T001R300x300M000004Be55m1SJaLk.jpg?max_age=2592000",
        musicList: List());
    _myPlayListMap[name] = playListModel;
    saveMyPlayList();
  }

  //添加歌曲到歌单
  void addMusicToPlayList(String playListTitle, MusicModel musicModel) {
    _myPlayListMap[playListTitle].musicList.add(musicModel);
    saveMyPlayList();
  }

  //删除歌单
  void deletePlayList(String name) {
    _myPlayListMap.remove(name);
    saveMyPlayList();
  }

  //删除歌单歌曲
  void deleteMusic(String playListTitle, MusicModel musicModel) {
    _myPlayListMap[playListTitle].musicList.remove(musicModel);
    saveMyPlayList();
  }
}
