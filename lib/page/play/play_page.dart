import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/page/play/play_music_action_bar.dart';
import 'package:listen2/page/play/play_music_progress.dart';
import 'package:listen2/page/play/play_music_tool_bar.dart';
import 'package:listen2/provider/play_musics_provider.dart';
import 'package:listen2/widgets/custom_scaffold.dart';
import 'package:listen2/widgets/marquee.dart';
import 'package:listen2/widgets/placeholder.dart';
import 'package:listen2/widgets/rounded_net_image.dart';
import 'package:provider/provider.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayMusicsProvider>(
      builder: (BuildContext context, PlayMusicsProvider provider,
          Widget playMusicPageBottom) {
        return CustomScaffold(
          backgroundColor: AppTheme.white,
          title: Text(
            provider.currentMusic.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 22,
                color: AppTheme.darkText,
                fontWeight: FontWeight.w700),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: LayoutBuilder(
              builder: (context, covariant) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      width: covariant.maxWidth,
                      height: covariant.maxHeight / 3,
                      child: RoundedNetImage(provider.currentMusic.picUrl,
                          height: covariant.maxHeight / 3,
                          width: covariant.maxHeight / 3,
                          radius: 20),
                    ),
                    //歌曲专辑信息
                    VerticalPlaceholder(10),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Marquee(
                            child: Text(
                              provider.currentMusic.name,
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(39, 39, 39, 0.9)),
                            ),
                          ),
                          Text(
                            provider.currentMusic.singer.name,
                            style: AppTheme.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            provider.currentMusic.album.name,
                            style: AppTheme.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // TODO 歌词可以放在此处
                          Expanded(
                            child: Center(
                              child: Text(
                                "歌词功能完善中",
                                style: TextStyle(color: AppTheme.nearlyBlack),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    playMusicPageBottom,
                    PlayMusicToolBar(),
                    VerticalPlaceholder(10)
                  ],
                );
              },
            ),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          PlayMusicActionBar(),
          PlayMusicProgressWidget(),
        ],
      ),
    );
  }
}
