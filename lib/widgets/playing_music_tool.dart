import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/provider/play_musics_provider.dart';
import 'package:listen2/utils/navigator_util.dart';
import 'package:listen2/widgets/rounded_net_image.dart';
import 'package:provider/provider.dart';

class PlayingMusicTool extends StatefulWidget {
  final double height;

  const PlayingMusicTool({Key key, this.height}) : super(key: key);

  @override
  _PlayingMusicToolState createState() => _PlayingMusicToolState();
}

class _PlayingMusicToolState extends State<PlayingMusicTool> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayMusicsProvider>(
      builder: (context, model, child) {
        //当前播放列表中有歌曲时,显示播放工具栏
        if (model.musicList.length > 0) {
          return GestureDetector(
            onTap: () {
              NavigatorUtil.goPlayPage(context);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(150)),
              child: SizedBox(
                height: widget.height,
                width: MediaQuery.of(context).size.width,
                child: LayoutBuilder(
                  builder: (context, covariant) {
                    return Opacity(
                      opacity: 0.9,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(2),
                                child: Hero(
                                  tag: "music_pic_" + model.currentMusic.id,
                                  child: model.currentMusic.picUrl != null
                                      ? RoundedNetImage(
                                          model.currentMusic.picUrl,
                                          width: covariant.maxHeight - 4,
                                          height: covariant.maxHeight - 4,
                                          radius: (covariant.maxHeight - 4) / 2,
                                        )
                                      : Container(
                                          width: covariant.maxHeight - 4,
                                          height: covariant.maxHeight - 4,
                                        ),
                                )),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        model.currentMusic.name,
                                        style: AppTheme.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          model.currentMusic.singer.name,
                                          style: AppTheme.subtitle,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: model.currentState ==
                                        AudioPlayerState.PLAYING
                                    ? Icon(Icons.pause_circle_outline)
                                    : Icon(Icons.play_circle_outline),
                                iconSize: widget.height * 0.7,
                                onPressed: () {
                                  model.togglePlay();
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(Icons.menu),
                                iconSize: widget.height * 0.7,
                                onPressed: () {
                                  showModalBottomSheet(
                                      elevation: 500,
                                      context: context,
                                      builder: (BuildContext context) {
                                        //TODO 当前播放列表
                                        return Container();
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
