import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:listen2/api/abstract_platform.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/page/play_list/play_list_grid_item.dart';
import 'package:listen2/utils/navigator_util.dart';

//歌单列表
class PlayListPage extends StatefulWidget {
  final PlatformsEnum platforms;

  const PlayListPage(this.platforms, {Key key}) : super(key: key);

  @override
  _PlayListPageState createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage>
    with TickerProviderStateMixin {
  AbstractPlatform api;
  int pageNum;
  List<PlayListModel> playListModelList;
  ScrollController scrollController;
  AnimationController animationController;
  Future _future;

  @override
  void initState() {
    pageNum = 1;
    api = AbstractPlatform.getPlatform(widget.platforms);
    playListModelList = new List();
    _future = getData();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    scrollController = ScrollController(keepScrollOffset: true);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          pageNum += 1;
          getData();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationController.dispose();
    super.dispose();
  }

  Future<List<PlayListModel>> getData() async {
    Map<String, dynamic> paramMap = new Map();
    paramMap["page"] = pageNum;
    return api
        .getPlayList(queryParameters: paramMap)
        .then((List<PlayListModel> list) {
      setState(() {
        playListModelList.addAll(list);
      });
      return list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PlayListModel>>(
        future: _future,
        builder: (BuildContext context,
            AsyncSnapshot<List<PlayListModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SpinKitCircle(
                color: AppTheme.nearlyBlack,
                size: 50,
              ),
            );
          } else {
            return CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 3 / 4),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    final int count = playListModelList.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: Interval((1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn),
                      ),
                    );
                    animationController.forward();
                    return PlayListGridItemWidget(
                      animation: animation,
                      animationController: animationController,
                      onTap: () {
                        NavigatorUtil.goPlayListMusicPage(context,
                            playListModel: playListModelList[index],
                            platform: widget.platforms);
                      },
                      playListModel: playListModelList[index],
                    );
                  }, childCount: playListModelList.length),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
