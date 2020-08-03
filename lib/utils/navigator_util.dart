import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:listen2/api/application.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/route/routes.dart';

import 'fluro_convert_utils.dart';

class NavigatorUtil {
  static _navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 300),
      RouteTransitionsBuilder transitionBuilder}) {
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        transition: TransitionType.inFromRight);
  }

  static void goHomePage(BuildContext context) {
    _navigateTo(context, Routes.home, clearStack: true);
  }

  static void goPlayListMusicPage(BuildContext context,
      {@required PlayListModel playListModel}) {
    _navigateTo(context,
        "${Routes.playListMusic}?playList=${FluroConvertUtils.object2string(playListModel)}");
  }

  static void goPlayPage(BuildContext context) {
    _navigateTo(context, Routes.play);
  }

  static void goSearchPage(BuildContext context) {
    _navigateTo(context, Routes.search);
  }

  static void goSearchResultPage(BuildContext context,
      {@required String keywords}) {
    _navigateTo(context,
        "${Routes.searchResult}?keywords=${Uri.encodeComponent(keywords)}");
  }
}
