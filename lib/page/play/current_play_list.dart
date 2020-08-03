import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen2/page/play/playing_music_list_item.dart';
import 'package:listen2/provider/play_musics_provider.dart';
import 'package:provider/provider.dart';

class CurrentPlayList extends StatefulWidget {
  @override
  _CurrentPlayListState createState() => _CurrentPlayListState();
}

class _CurrentPlayListState extends State<CurrentPlayList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayMusicsProvider>(
      builder: (context, model, child) {
        return Container(
            height: ScreenUtil.screenHeight / 2,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: InkWell(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            FlatButton.icon(
                              icon: Icon(Icons.loop),
                              label: Text("顺序播放(${model.musicList.length})"),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {
                            model.removeAll();
                          },
                        ),
                      )
                    ],
                  )),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverFixedExtentList(
                        itemExtent: ScreenUtil().setHeight(100),
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return PlayingMusicListItemWidget(
                            model.musicList[index],
                            onTap: () {
                              model.playIndex(index);
                            },
                            onTapDelete: () {
                              model.removeMusic(index);
                            },
                            isCurrentMusic:
                                model.musicList[index] == model.currentMusic,
                          );
                        }, childCount: model.musicList.length),
                      )
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}
