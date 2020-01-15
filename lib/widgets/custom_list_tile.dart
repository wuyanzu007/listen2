import 'package:flutter/material.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/widgets/placeholder.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget trailing;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CustomListTile(
      {Key key,
      this.leading,
      this.trailing,
      this.title,
      this.subtitle,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          child: Row(
            children: <Widget>[
              HorizontalPlaceholder(9.0),
              leading != null ? leading : Container(),
              HorizontalPlaceholder(20.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: AppTheme.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: AppTheme.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              trailing != null ? trailing : Container()
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
