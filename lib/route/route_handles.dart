import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:listen2/navigation_home_screen.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/page/play/play_page.dart';
import 'package:listen2/page/play_list_music/play_list_music_page.dart';
import 'package:listen2/page/search/search_page.dart';
import 'package:listen2/page/search/search_result_page.dart';
import 'package:listen2/utils/fluro_convert_utils.dart';

var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return NavigationHomeScreen();
});

var playListMusicHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  PlayListModel playList = PlayListModel.fromJson(
      FluroConvertUtils.string2map(params["playList"].first));
  return PlayListMusicPage(
    playListModel: playList,
  );
});

var playHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return PlayPage();
//  return PlayMusicPage();
});

var searchHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return SearchPage();
//  return PlayMusicPage();
});

var searchResultHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  String keywords = params["keywords"].first;
  return SearchResultPage(
    keywords: keywords,
  );
});
