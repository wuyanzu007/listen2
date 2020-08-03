import 'package:flutter/material.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/widgets/rounded_net_image.dart';

class MyPlayListGrid extends StatelessWidget {
  final PlayListModel playListModel;

  const MyPlayListGrid({Key key, this.playListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return RoundedNetImage(
                    playListModel.imageUrl,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    fit: BoxFit.fill,
                    radius: 0.0,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        playListModel.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.subtitle,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "共 ${playListModel.musicList.length} 首",
                        style: AppTheme.subtitle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
