import 'package:flutter/material.dart';
import 'package:listen2/api/abstract_platform.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/provider/search_provider.dart';
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

  @override
  void initState() {
    super.initState();
    textEditingValue = TextEditingValue(text: widget.keywords);
    print(widget.keywords);
    textEditingController = TextEditingController();
    var provider = Provider.of<SearchProvider>(context, listen: false);
    api = provider.api;
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
                },
              )
            ],
          );
        },
      ),
      body: Container(
        child: Center(
          child: Text("没有相关结果"),
        ),
      ),
    );
  }
}
