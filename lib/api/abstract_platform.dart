import 'package:listen2/api/mi_gu_api.dart';
import 'package:listen2/api/netease_api.dart';
import 'package:listen2/api/qq_api.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/models/music_model.dart';
import 'package:listen2/models/play_list_model.dart';

abstract class AbstractPlatform {
  /// 获取歌单列表
  /// page: 页码
  Future<List<PlayListModel>> getPlayList(
      {Map<String, dynamic> queryParameters});

  /// 获取歌单歌曲
  /// playListId: 歌单Id
  Future<List<MusicModel>> getPlayListMusic(
      {Map<String, dynamic> queryParameters});

  /// 获取歌曲详情
  /// musicId: 歌曲Id
  Future<MusicModel> getMusicDetail({MusicModel param});

  /// 获取热搜
  Future<List<String>> getHotSearch({Map<String, dynamic> queryParameters});

  /// 搜索
  /// currentPage: 页码
  /// queryStr: 搜索关键字
  Future<List<MusicModel>> search({Map<String, dynamic> queryParameters});

  //获取歌手歌曲

  //获取专辑详情

  static AbstractPlatform getPlatform(PlatformsEnum platformsEnum) {
    return _getInstance(platformsEnum);
  }

  static AbstractPlatform _getInstance(PlatformsEnum platformsEnum) {
    switch (platformsEnum) {
      case PlatformsEnum.MI_GU:
        return MiGuApi();
        break;
      case PlatformsEnum.QQ:
        return QQApi();
        break;
      case PlatformsEnum.NETEASE:
        return NeteaseApi();
        break;
      case PlatformsEnum.BI_LI_BI_LI:
        // TODO: Handle this case.
        return null;
        break;
    }
    return null;
  }
}
