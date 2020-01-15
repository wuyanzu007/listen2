import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:listen2/api/abstract_platform.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/models/music_model.dart';
import 'package:listen2/provider/play_musics_provider.dart';
import 'package:listen2/provider/search_provider.dart';
import 'package:listen2/utils/navigator_util.dart';
import 'package:listen2/widgets/custom_list_tile.dart';
import 'package:listen2/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatefulWidget {
  final String keywords;

  const SearchResultPage({Key key, this.keywords}) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  TextEditingController textEditingController;
  TextEditingValue textEditingValue;
  AbstractPlatform api;
  List<MusicModel> searchResult = [];
  Future<List<MusicModel>> searchFuture;
  String keywords;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    keywords = widget.keywords;
    textEditingValue = TextEditingValue(text: keywords);
    textEditingController = TextEditingController();
    var provider = Provider.of<SearchProvider>(context, listen: false);
    api = provider.api;
    getData(keywords);
  }

  Future<void> getData(String keywords) async {
    var queryParameters = {
      "queryStr": keywords,
      "currentPage": currentPage
    };
    searchFuture = api.search(queryParameters: queryParameters);
    setState(() {
      searchFuture.then((musicList) => searchResult.addAll(musicList));
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: TextField(
        onSubmitted: (keywords){
          getData(keywords);
        },
        controller: textEditingController,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      action: Consumer<SearchProvider>(
        builder: (BuildContext context, SearchProvider provider, Widget child) {
          return Row(
            children: <Widget>[
              DropdownButton(
                value: provider.platforms,
                underline: Container(),
                items: PlatformsEnum.values
                    .map((platforms) => DropdownMenuItem<PlatformsEnum>(
                          key: Key(platforms.name),
                          value: platforms,
                          child: Text(platforms.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  provider.changePlatform(value);
                  api = provider.api;
                  searchResult.clear();
                  currentPage = 0;
                  getData(keywords);
                },
              )
            ],
          );
        },
      ),
      body: Container(
        child: FutureBuilder(
          future: searchFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  itemCount: searchResult.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Consumer<PlayMusicsProvider>(
                      builder: (BuildContext context,
                          PlayMusicsProvider provider, Widget child) {
                        return CustomListTile(
                          leading: Text(
                            (index + 1).toString(),
                            style: AppTheme.title,
                          ),
                          title: searchResult[index].name,
                          subtitle: searchResult[index].singer.name +
                              "-" +
                              searchResult[index].album.name,
                          onTap: () {
                            provider.addMusic(searchResult[index]);
                            NavigatorUtil.goPlayPage(context);
                          },
                        );
                      },
                    );
                  });
            } else {
              return SpinKitCircle(
                color: AppTheme.nearlyBlack,
              );
            }
          },
        ),
      ),
    );
  }
}
