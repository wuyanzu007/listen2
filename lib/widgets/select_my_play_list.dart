import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/provider/my_paly_list_provider.dart';
import 'package:listen2/widgets/custom_list_tile.dart';
import 'package:listen2/widgets/rounded_net_image.dart';
import 'package:provider/provider.dart';

class SelectMyPlayList {
  static Future<PlayListModel> showNewPlayListDialog(context) async {
    return await showDialog<PlayListModel>(
        context: context,
        builder: (BuildContext context) {
          return Consumer<MyPlayListProvider>(
            builder: (context, model, child) {
              return SimpleDialog(
                title: const Text('请选择歌单'),
                children: model.myPlayListList
                    .map((myPlaylist) => Container(
                          child: CustomListTile(
                            leading: RoundedNetImage(
                              myPlaylist.imageUrl,
                              width: ScreenUtil().setWidth(100),
                              height: ScreenUtil().setWidth(100),
                            ),
                            title: myPlaylist.title,
                            subtitle: "共 ${myPlaylist.musicList.length} 首",
                            onTap: () {
                              Navigator.pop(context, myPlaylist);
                            },
                          ),
                        ))
                    .toList(),
              );
            },
          );
        });
  }
}
