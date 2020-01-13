import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:listen2/route/navigate_service.dart';
import 'package:listen2/route/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application {
  static Router router;
  static GlobalKey<NavigatorState> key = GlobalKey();
  static SharedPreferences sp;
  static double screenWidth;
  static double screenHeight;
  static double statusBarHeight;
  static GetIt getIt = GetIt.instance;
  static String miGuSecret;
  static ThemeData themeData;

  static init() {
    Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    initSp();
    initMiGuPublicKey();
    setupLocator();
  }

  static initSp() async {
    sp = await SharedPreferences.getInstance();
  }

  static initMiGuPublicKey() async {
    final directory = await getApplicationDocumentsDirectory();
    String dir = directory.path;
    final file = File('$dir/migu-public.pem');
    await file.writeAsString("-----BEGIN PUBLIC KEY-----"
        "\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC8asrfSaoOb4je+DSmKdriQJKW"
        "\nVJ2oDZrs3wi5W67m3LwTB9QVR+cE3XWU21Nx+YBxS0yun8wDcjgQvYt625ZCcgin"
        "\n2ro/eOkNyUOTBIbuj9CvMnhUYiR61lC1f1IGbrSYYimqBVSjpifVufxtx/I3exRe"
        "\nZosTByYp4Xwpb1+WAQIDAQAB"
        "\n-----END PUBLIC KEY-----");
  }

  static setupLocator() {
    getIt.registerSingleton(NavigateService());
  }
}
