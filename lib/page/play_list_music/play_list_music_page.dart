import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:listen2/api/abstract_platform.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/models/music_model.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/provider/my_paly_list_provider.dart';
import 'package:listen2/provider/play_musics_provider.dart';
import 'package:listen2/utils/navigator_util.dart';
import 'package:listen2/widgets/flexible_detail_bar.dart';
import 'package:listen2/widgets/placeholder.dart';
import 'package:listen2/widgets/rounded_net_image.dart';
import 'package:provider/provider.dart';

//歌曲列表页面
class PlayListMusicPage extends StatefulWidget {
  final PlayListModel playListModel;

  const PlayListMusicPage({Key key, this.playListModel}) : super(key: key);

  @override
  _PlayListMusicPageState createState() => _PlayListMusicPageState();
}

class _InheritedMusicListFuture extends InheritedWidget {
  final Future<List<MusicModel>> musicListFuture;

  _InheritedMusicListFuture({this.musicListFuture, Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(_InheritedMusicListFuture oldWidget) {
    return musicListFuture != oldWidget.musicListFuture;
  }

  static _InheritedMusicListFuture of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_InheritedMusicListFuture>();
}

class _PlayListMusicPageState extends State<PlayListMusicPage> {
  AbstractPlatform _api;
  Future<List<MusicModel>> _musicListFuture;
  MyPlayListProvider _myPlayListProvider;

  @override
  void initState() {
    _api = AbstractPlatform.getPlatform(widget.playListModel.platform);
    _myPlayListProvider =
        Provider.of<MyPlayListProvider>(context, listen: false);
    _musicListFuture = getData();
    super.initState();
  }

  Future<List<MusicModel>> getData() async {
    Map<String, dynamic> paramMap = new Map();
    paramMap["playListId"] = widget.playListModel.id;
    if (widget.playListModel.platform == null) {
      return widget.playListModel.musicList;
    }
    return _api.getPlayListMusic(queryParameters: paramMap);
  }

  Widget buildButtonColumn(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(msg: label + "功能完善中");
      },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              icon,
              color: AppTheme.nearlyWhite,
            ),
            new Container(
              margin: const EdgeInsets.only(top: 8),
              child: new Text(
                label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.nearlyWhite),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _InheritedMusicListFuture(
        musicListFuture: _musicListFuture,
        child: CustomScrollView(
          slivers: <Widget>[
            PlayListMusicSliverAppBar(
              title: widget.playListModel.title,
              expandedHeight: ScreenUtil().setHeight(600),
              sigma: 20,
              backgroundImg: widget.playListModel.imageUrl,
              content: Padding(
                padding: EdgeInsets.only(
                    bottom: ScreenUtil().setHeight(60),
                    top: kToolbarHeight + MediaQuery.of(context).padding.top),
                child: Container(
                  //TODO 歌单歌曲列表样式调整
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Center(
                            child: RoundedNetImage(
                              widget.playListModel.imageUrl,
                              height: constraints.maxWidth - 10,
                              width: constraints.maxWidth - 10,
                              radius: 20,
                            ),
                          );
                        }),
                      ),
                      Expanded(
                        flex: 1,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: constraints.maxWidth - 10,
                              width: constraints.maxWidth - 10,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      widget.playListModel.title,
                                      style: TextStyle(
                                          color: AppTheme.nearlyWhite,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      buildButtonColumn(Icons.comment, "评论"),
                                      buildButtonColumn(Icons.share, "分享"),
                                      buildButtonColumn(
                                          Icons.file_download, "下载"),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _musicListFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<List<MusicModel>> snapshot) {
                if (!snapshot.hasData) {
                  return SliverFillRemaining(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                          child: SpinKitCircle(
                        color: AppTheme.nearlyBlack,
                      )),
                    ),
                  );
                } else {
                  var musicList = snapshot.data;
                  return Consumer<PlayMusicsProvider>(
                    builder: (BuildContext context, PlayMusicsProvider provider,
                        Widget child) {
                      return SliverFixedExtentList(
                        itemExtent: 60,
                        delegate: SliverChildListDelegate(musicList
                            .map((music) => ListTile(
                                  title: Text(
                                    music.name,
                                    style: AppTheme.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: PopupMenuButton(
                                    padding: const EdgeInsets.all(0),
                                    icon: Icon(Icons.more_vert),
                                    onSelected: (value) {
                                      switch (value) {
                                        case 1:
                                          //播放
                                          provider.addMusic(music);
                                          break;
                                        case 2:
                                          //删除
                                          setState(() {
                                            _myPlayListProvider.deleteMusic(
                                                widget.playListModel.title, music);
                                          });
                                          break;
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry>[
                                        PopupMenuItem(
                                          value: 1,
                                          child: Center(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(Icons.play_arrow),
                                                HorizontalPlaceholder(10),
                                                Text("播放")
                                              ],
                                            ),
                                          ),
                                        ),
                                        widget.playListModel.platform == null
                                            ? PopupMenuItem(
                                                value: 2,
                                                child: Center(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(Icons.delete),
                                                      HorizontalPlaceholder(10),
                                                      Text("删除")
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : null,
                                      ];
                                    },
                                  ),
                                  subtitle: Text(
                                    music.singer.name + music.album.name,
                                    style: AppTheme.subtitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    provider.addMusic(music);
                                    NavigatorUtil.goPlayPage(context);
                                  },
                                ))
                            .toList()),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class PlayListMusicSliverAppBar extends StatelessWidget {
  final double expandedHeight;
  final Widget content;
  final String backgroundImg;
  final String title;
  final double sigma;

  const PlayListMusicSliverAppBar({
    Key key,
    @required this.expandedHeight,
    @required this.content,
    @required this.backgroundImg,
    @required this.title,
    this.sigma = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      expandedHeight: expandedHeight,
      pinned: true,
      title: Text(
        title,
        style: AppTheme.textTheme.headline,
      ),
      bottom: PlayListMusicSliverAppBarBottom(),
      flexibleSpace: FlexibleDetailBar(
        content: content,
        background: Stack(
          children: <Widget>[
            ExtendedImage.network(
              backgroundImg,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
              child: Container(
                color: Colors.white30,
                width: double.infinity,
                height: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlayListMusicSliverAppBarBottom extends StatefulWidget
    with PreferredSizeWidget {
  PlayListMusicSliverAppBarBottom({Key key}) : super(key: key);

  @override
  _PlayListMusicSliverAppBarBottomState createState() =>
      _PlayListMusicSliverAppBarBottomState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(80));
}

class _PlayListMusicSliverAppBarBottomState
    extends State<PlayListMusicSliverAppBarBottom> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      child: Container(
        color: Colors.white,
        child: InkWell(
          child: SizedBox.fromSize(
            size: widget.preferredSize,
            child: Row(
              children: <Widget>[
                FutureBuilder(
                  future: _InheritedMusicListFuture.of(context).musicListFuture,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Row(
                        children: <Widget>[
                          SpinKitCircle(
                            color: AppTheme.nearlyBlack,
                            size: 18,
                          ),
                          Text(
                            "请稍后...",
                            style: AppTheme.title,
                          )
                        ],
                      );
                    } else {
                      return Consumer<PlayMusicsProvider>(
                        builder: (BuildContext context,
                            PlayMusicsProvider provider, Widget child) {
                          return FlatButton.icon(
                              onPressed: () {
                                provider.addMusics(snapshot.data);
                                NavigatorUtil.goPlayPage(context);
                              },
                              icon: Icon(Icons.play_circle_outline),
                              label: Text(
                                "播放全部",
                                style: AppTheme.title,
                              ));
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
