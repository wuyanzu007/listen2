import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:listen2/page/play/current_play_list.dart';
import 'package:listen2/provider/play_musics_provider.dart';
import 'package:listen2/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';

class PlayMusicToolBar extends StatefulWidget {
  @override
  _PlayMusicToolBarState createState() => _PlayMusicToolBarState();
}

class _PlayMusicToolBarState extends State<PlayMusicToolBar> {
  bool buttonDisable;

  @override
  void initState() {
    buttonDisable = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PlayMusicsProvider>(context, listen: false);

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CustomIconButton(
          icon: Icons.loop,
          color: Colors.grey,
          size: 30,
          wrapSize: 50,
          onTap: () {
            //TODO 切换歌曲播放模式
          },
        ),
        CustomIconButton(
          icon: Icons.skip_previous,
          color: Colors.grey,
          size: 30,
          wrapSize: 50,
          onTap: buttonDisable
              ? null
              : () {
                  provider.prePlay();
                },
        ),
        CustomIconButton(
          icon: provider.currentState == AudioPlayerState.PLAYING
              ? Icons.pause
              : Icons.play_arrow,
          color: Colors.grey,
          size: 50,
          wrapSize: 50,
          onTap: buttonDisable
              ? null
              : () {
                  provider.togglePlay();
                },
        ),
        CustomIconButton(
          icon: Icons.skip_next,
          color: Colors.grey,
          size: 30,
          wrapSize: 50,
          onTap: buttonDisable
              ? null
              : () {
                  provider.nextPlay();
                },
        ),
        CustomIconButton(
          icon: Icons.playlist_play,
          color: Colors.grey,
          size: 30,
          wrapSize: 50,
          onTap: () {
            //TODO 播放列表
            showModalBottomSheet(
                elevation: 500,
                context: context,
                builder: (BuildContext context) {
                  //TODO 当前播放列表
                  return CurrentPlayList();
                });
          },
        ),
      ],
    );
  }
}
