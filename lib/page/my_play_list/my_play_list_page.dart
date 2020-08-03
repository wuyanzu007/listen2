import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/page/my_play_list/my_play_list_grid.dart';
import 'package:listen2/provider/my_paly_list_provider.dart';
import 'package:listen2/utils/navigator_util.dart';
import 'package:listen2/widgets/custom_icon_button.dart';
import 'package:listen2/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class MyPlayListPage extends StatefulWidget {
  const MyPlayListPage({Key key}) : super(key: key);

  @override
  _MyPlayListPageState createState() => _MyPlayListPageState();
}

class _MyPlayListPageState extends State<MyPlayListPage> {
  List<PlayListModel> myPlayList = new List();
  MyPlayListProvider provider;
  TextEditingController _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<MyPlayListProvider>(context, listen: false);
    _getMyPlayList();
    _textEditingController = TextEditingController();
  }

  Future<bool> showNewPlayListDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("添加新歌单"),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: "歌单名称"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("保存"),
              onPressed: () {
                setState(() {
                  print(_textEditingController.text);
                  provider.addMyPlayList(_textEditingController.text);
                  Navigator.of(context).pop(true);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _getMyPlayList() {
    myPlayList = provider.myPlayListList;
  }

  void _addMyPlayList() {
    showNewPlayListDialog();
  }

  void _deleteMyPlayList(index) {
    setState(() {
      provider.deletePlayList(index);
    });
  }

  void _showDeleteConform(index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("确定要删除该歌单吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteMyPlayList(index);
                },
              )
            ],
          );
        });
  }

  Widget _newPlayListWidget = Container(
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  color: Color(0xFFF1F3F4),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.grey,
                      size: constraints.maxHeight,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Center(
                child: Text(
                  "添加新歌单",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );

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
        action: CustomIconButton(
          icon: Icons.search,
          color: Colors.grey,
          size: 30,
          wrapSize: AppBar().preferredSize.height - 8,
          onTap: () {
            NavigatorUtil.goSearchPage(context);
          },
        ),
        body: AnimationLimiter(
            child: GridView.count(
          childAspectRatio: 3.0,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          padding: EdgeInsets.all(8),
          crossAxisCount: 2,
          children: List.generate(myPlayList.length + 1, (int index) {
            Widget _child;
            Function _onTap;
            Function _onLongPress;
            if (index == myPlayList.length) {
              //添加最后一个添加选项
              _child = _newPlayListWidget;
              _onTap = _addMyPlayList;
            } else {
              _child = MyPlayListGrid(
                playListModel: myPlayList[index],
              );
              _onTap = () {
                NavigatorUtil.goPlayListMusicPage(context,
                    playListModel: myPlayList[index]);
              };
              _onLongPress = () {
                _showDeleteConform(index);
              };
            }
            return AnimationConfiguration.staggeredGrid(
                duration: Duration(milliseconds: 500),
                position: index,
                columnCount: 2,
                child: ScaleAnimation(
                    scale: 0.5,
                    child: FadeInAnimation(
                        child: GestureDetector(
                      onLongPress: _onLongPress,
                      onTap: _onTap,
                      child: _child,
                    ))));
          }),
        )));
  }
}
