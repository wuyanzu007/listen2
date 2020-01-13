import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:listen2/navigation_home_screen.dart';
import 'package:listen2/route/route_handles.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String playListMusic = "/playListMusic";
  static String play = "/play";
  static String search = "/search";
  static String searchResult = "/searchResult";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return NavigationHomeScreen();
    });
    router.define(home, handler: homeHandler);
    router.define(root, handler: homeHandler);
    router.define(playListMusic, handler: playListMusicHandler);
    router.define(play, handler: playHandler);
    router.define(search, handler: searchHandler);
    router.define(searchResult, handler: searchResultHandler);
  }
}
