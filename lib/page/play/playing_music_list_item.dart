import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen2/models/music_model.dart';

class PlayingMusicListItemWidget extends StatelessWidget {
  final MusicModel _musicModel;
  final VoidCallback onTap;
  final VoidCallback onTapDelete;
  final bool isCurrentMusic;

  const PlayingMusicListItemWidget(this._musicModel,
      {Key key, this.onTap, this.onTapDelete, this.isCurrentMusic: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: ScreenUtil.screenWidth,
        height: ScreenUtil().setHeight(120),
        padding: EdgeInsets.only(left: 10, right: 5),
        child: Row(
          children: <Widget>[
            isCurrentMusic
                ? Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.play_arrow),
                  )
                : Container(),
            Expanded(
                child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: _musicModel.name,
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                TextSpan(
                  text: " - " + _musicModel.singer.name,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ]),
            )),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.clear),
                onPressed: onTapDelete,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
