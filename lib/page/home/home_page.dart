import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/page/play_list/play_list_page.dart';
import 'package:listen2/utils/navigator_util.dart';
import 'package:listen2/widgets/custom_scaffold.dart';
import 'package:listen2/widgets/playing_music_tool.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;
  List tabs = PlatformsEnum.values.map((platform) => platform.name).toList();

  List<Widget> tabViews =
      PlatformsEnum.values.map((platform) => PlayListPage(platform)).toList();

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabViews.length);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppTheme.white,
      leading: Container(),
      title: Text(
        "Listen 2",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 22,
            color: AppTheme.darkText,
            fontWeight: FontWeight.w700),
      ),
      action: InkWell(
        borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
        child: Icon(
          Icons.search,
          color: Colors.grey,
        ),
        onTap: () {
          NavigatorUtil.goSearchPage(context);
        },
      ),
      bottom: TabBar(
        controller: _tabController,
        tabs: tabs
            .map((e) => Tab(
                  child: Text(
                    e,
                    style: AppTheme.textTheme.title,
                  ),
                ))
            .toList(),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          TabBarView(
            controller: _tabController,
            children: tabViews.map((e) => e).toList(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: PlayingMusicTool(
              height: ScreenUtil().setHeight(100),
            ),
          )
        ],
      ),
    );
  }
}
