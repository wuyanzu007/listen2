import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/widgets/custom_scaffold.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key key}) : super(key: key);

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
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "如果你有什么意见或建议,请前往以下地址",
                  style: AppTheme.title,
                ),
                Text("https://www.github.com/wuyanzu007/listen2",
                    style: AppTheme.title),
              ],
            ),
          ),
        ));
  }
}
