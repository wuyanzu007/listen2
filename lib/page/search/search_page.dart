import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:listen2/api/abstract_platform.dart';
import 'package:listen2/api/application.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/provider/search_provider.dart';
import 'package:listen2/utils/navigator_util.dart';
import 'package:listen2/widgets/custom_list_tile.dart';
import 'package:listen2/widgets/custom_scaffold.dart';
import 'package:listen2/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  AnimationController iconAnimationController;
  TextEditingController textEditingController;
  AbstractPlatform api;
  Future hotSearchFuture;

  List<String> searchHistory = [];
  List<String> hotSearch = [];

  @override
  void initState() {
    iconAnimationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    iconAnimationController.forward();

    textEditingController = TextEditingController();

    var provider = Provider.of<SearchProvider>(context, listen: false);
    api = provider.api;
    getHotSearch();
    getHistory();
    super.initState();
  }

  void getHotSearch() {
    setState(() {
      hotSearchFuture = api.getHotSearch();
      hotSearchFuture
          .then((result) => hotSearch = result)
          .catchError((error) => Fluttertoast.showToast(msg: "获取排行榜信息时发生错误"));
    });
  }

  void getHistory() {
    setState(() {
      searchHistory = Application.sp.containsKey("searchHistory")
          ? new List<String>.from(Application.sp.get("searchHistory"))
          : [];
    });
  }

  void search(String keywords) {
    if (keywords != null && keywords.isNotEmpty) {
      setState(() {
        searchHistory.remove(keywords);
        searchHistory.insert(0, keywords);
      });
      Application.sp.setStringList("searchHistory", searchHistory);
      NavigatorUtil.goSearchResultPage(context, keywords: keywords);
    } else {
      Fluttertoast.showToast(msg: "请输入搜索关键字");
    }
  }

  @override
  void dispose() {
    super.dispose();
    iconAnimationController.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: TextField(
        controller: textEditingController,
        onSubmitted: (keywords) {
          search(keywords);
        },
      ),
      backgroundColor: AppTheme.nearlyWhite,
      action: Consumer<SearchProvider>(
        builder: (BuildContext context, SearchProvider provider, Widget child) {
          List<PlatformsEnum> searchPlatforms = List<PlatformsEnum>.from(PlatformsEnum.values);
          //搜索不支持哔哩哔哩
          searchPlatforms.remove(PlatformsEnum.BI_LI_BI_LI);
          return Row(
            children: <Widget>[
              DropdownButton(
                value: provider.platforms,
                underline: Container(),
                items: searchPlatforms
                    .map((platforms) => DropdownMenuItem<PlatformsEnum>(
                          key: Key(platforms.name),
                          value: platforms,
                          child: Text(platforms.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  provider.changePlatform(value);
                  api = provider.api;
                  getHotSearch();
                },
              )
            ],
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 30),
        child: CustomScrollView(slivers: <Widget>[
          SliverToBoxAdapter(
            child: Text(
              "搜索历史",
              style: AppTheme.title,
            ),
          ),
          SliverToBoxAdapter(
            child: VerticalPlaceholder(10),
          ),
          _searchHistoryWidget(),
          SliverToBoxAdapter(
            child: VerticalPlaceholder(30),
          ),
          SliverToBoxAdapter(
            child: Text(
              "热门搜索",
              style: AppTheme.title,
            ),
          ),
          SliverToBoxAdapter(
            child: VerticalPlaceholder(10),
          ),
          FutureBuilder(
            future: hotSearchFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return _hotSearchWidget();
              } else {
                return SliverToBoxAdapter(
                  child: SpinKitCircle(
                    color: AppTheme.nearlyBlack,
                  ),
                );
              }
            },
          )
        ]),
      ),
    );
  }

  Widget _hotSearchWidget() {
    List<Widget> widgetList = [];

    hotSearch.asMap().forEach((index, text) => {
          widgetList.add(CustomListTile(
            leading: Text(
              (index + 1).toString(),
              style: AppTheme.title,
            ),
            title: text,
            subtitle: text,
            onTap: () {
              search(text);
            },
          ))
        });

    return SliverFixedExtentList(
      itemExtent: 60,
      delegate: SliverChildListDelegate(widgetList),
    );
  }

  Widget _searchHistoryWidget() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: searchHistory
              .map((text) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: RaisedButton(
                        child: Text(text),
                        onPressed: () {
                          search(text);
                        },
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
