import 'package:flutter/material.dart';
import 'package:listen2/api/abstract_platform.dart';
import 'package:listen2/common/enums.dart';

class SearchProvider with ChangeNotifier {
  AbstractPlatform _api;

  PlatformsEnum _platforms;

  AbstractPlatform get api => _api;

  PlatformsEnum get platforms => _platforms;

  void init() {
    _api = AbstractPlatform.getPlatform(PlatformsEnum.MI_GU);
    _platforms = PlatformsEnum.MI_GU;
  }

  void changePlatform(PlatformsEnum platform) {
    _api = AbstractPlatform.getPlatform(platform);
    _platforms = platform;
    notifyListeners();
  }
}
