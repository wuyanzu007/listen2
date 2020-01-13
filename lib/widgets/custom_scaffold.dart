import 'package:flutter/material.dart';
import 'package:listen2/widgets/custom_animated_icon_button.dart';

class CustomScaffold extends StatefulWidget {
  final Color backgroundColor;
  final Widget title;
  final Widget action;
  final Widget leading;
  final Widget body;
  final Widget bottom;

  const CustomScaffold(
      {Key key,
      @required this.backgroundColor,
      @required this.title,
      this.action,
      this.leading,
      @required this.body,
      this.bottom})
      : super(key: key);

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              appBar(),
              widget.bottom != null ? widget.bottom : Container(),
              Expanded(
                child: widget.body,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: Material(
                color: Colors.transparent,
                child: widget.leading == null
                    ? CustomAnimatedIconButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    : widget.leading,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: widget.title,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0,right: 8.0),
            child: Container(
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: widget.action,
              ),
            ),
          )
        ],
      ),
    );
  }
}
