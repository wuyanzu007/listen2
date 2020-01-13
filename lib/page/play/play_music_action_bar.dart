import 'package:flutter/material.dart';
import 'package:listen2/widgets/custom_icon_button.dart';

class PlayMusicActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CustomIconButton(
          icon: Icons.share,
          color: Colors.grey,
          size: 30,
          wrapSize: 50,
          onTap: () {
            //TODO 分享
          },
        ),
        CustomIconButton(
          icon: Icons.comment,
          color: Colors.grey,
          size: 30,
          wrapSize: 50,
          onTap: () {
            //TODO 评论
          },
        ),
        CustomIconButton(
          icon: Icons.file_download,
          color: Colors.grey,
          size: 30,
          wrapSize: 50,
          onTap: () {
            //TODO 下载
          },
        ),
        CustomIconButton(
          icon: Icons.favorite,
          color: Colors.grey,
          size: 30,
          wrapSize: 50,
          onTap: () {
            //TODO 收藏
          },
        ),
        CustomIconButton(
          icon: Icons.add,
          color: Colors.grey,
          size: 30,
          wrapSize: 50,
          onTap: () {
            //TODO 添加到个人歌单
          },
        ),
      ],
    );
  }
}
