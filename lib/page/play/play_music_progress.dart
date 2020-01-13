import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/provider/play_musics_provider.dart';
import 'package:provider/provider.dart';

class PlayMusicProgressWidget extends StatelessWidget {

  const PlayMusicProgressWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PlayMusicsProvider>(context,listen: false);
    return StreamBuilder<String>(
      stream: provider.currentPositionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var totalTime =
              snapshot.data.substring(snapshot.data.indexOf('-') + 1);
          var curTime = double.parse(
              snapshot.data.substring(0, snapshot.data.indexOf('-')));
          var curTimeStr =
              DateUtil.formatDateMs(curTime.toInt(), format: "mm:ss");
          return buildProgress(curTime, totalTime, curTimeStr,provider);
        } else {
          return buildProgress(0, "0", "00:00",provider);
        }
      },
    );
  }

  Widget buildProgress(
      double curTime, String totalTime, String currentTimeStr, provider) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            currentTimeStr,
            style: AppTheme.subtitle,
          ),
          Expanded(
            child: Slider(
              value: curTime,
              onChanged: (data) {
                provider.sinkProgress(data.toInt());
              },
              onChangeStart: (data) {
                provider.pausePlay();
              },
              onChangeEnd: (data) {
                provider.seekPlay(data.toInt());
              },
              activeColor: Colors.redAccent,
              inactiveColor: Colors.black26,
              min: 0,
              max: double.parse(totalTime),
            ),
          ),
          Text(
            DateUtil.formatDateMs(int.parse(totalTime), format: "mm:ss"),
            style: AppTheme.subtitle,
          )
        ],
      ),
    );
  }
}
