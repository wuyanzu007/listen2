import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/provider/my_paly_list_provider.dart';
import 'package:listen2/provider/play_musics_provider.dart';
import 'package:listen2/widgets/custom_icon_button.dart';
import 'package:listen2/widgets/select_my_play_list.dart';
import 'package:provider/provider.dart';

class PlayMusicActionBar extends StatefulWidget {
  @override
  _PlayMusicActionBarState createState() => _PlayMusicActionBarState();
}

class _PlayMusicActionBarState extends State<PlayMusicActionBar> {
  MyPlayListProvider _myPlayListProvider;
  PlayMusicsProvider _playMusicsProvider;

  @override
  void initState() {
    super.initState();
    _myPlayListProvider =
        Provider.of<MyPlayListProvider>(context, listen: false);
    _playMusicsProvider =
        Provider.of<PlayMusicsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CustomIconButton(
          icon: Icons.share,
          color: Colors.grey,
          size: ScreenUtil().setWidth(50),
          wrapSize: ScreenUtil().setWidth(100),
          onTap: () {
            //TODO 分享
          },
        ),
        CustomIconButton(
          icon: Icons.comment,
          color: Colors.grey,
          size: ScreenUtil().setWidth(50),
          wrapSize: ScreenUtil().setWidth(100),
          onTap: () {
            //TODO 评论
          },
        ),
        CustomIconButton(
          icon: Icons.file_download,
          color: Colors.grey,
          size: ScreenUtil().setWidth(50),
          wrapSize: ScreenUtil().setWidth(100),
          onTap: () {
            //TODO 下载
          },
        ),
        CustomIconButton(
          icon: Icons.favorite,
          color: Colors.grey,
          size: ScreenUtil().setWidth(50),
          wrapSize: ScreenUtil().setWidth(100),
          onTap: () {
            //TODO 收藏
          },
        ),
        CustomIconButton(
          icon: Icons.add,
          color: Colors.grey,
          size: ScreenUtil().setWidth(50),
          wrapSize: ScreenUtil().setWidth(100),
          onTap: () async {
            //TODO 添加到个人歌单
            PlayListModel playListModel =
                await SelectMyPlayList.showNewPlayListDialog(context);
            if (playListModel != null) {
              _myPlayListProvider.addMusicToPlayList(
                  playListModel.title, _playMusicsProvider.currentMusic);
            }
          },
        ),
      ],
    );
  }
}
