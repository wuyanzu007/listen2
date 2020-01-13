import 'package:flutter/material.dart';
import 'package:listen2/models/play_list_model.dart';
import 'package:listen2/widgets/rounded_net_image.dart';

class PlayListGridItemWidget extends StatelessWidget {
  final PlayListModel playListModel;
  final VoidCallback onTap;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  const PlayListGridItemWidget(
      {Key key,
      @required this.playListModel,
      this.onTap,
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: animation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 5.0 * (1.0 - animation.value), 0.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: onTap,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RoundedNetImage(
                            playListModel.imageUrl,
                            fit: BoxFit.fill,
                            width: constraints.maxWidth - 5,
                            height: constraints.maxWidth - 5,
                            radius: 10.0,
                          ),
                          Container(
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                playListModel.title,
                                style: TextStyle(fontSize: 11),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
