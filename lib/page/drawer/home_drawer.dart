import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/widgets/rounded_net_image.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key key,
      this.iconAnimationController,
      this.screenIndex,
      this.callBackIndex})
      : super(key: key);

  final AnimationController iconAnimationController;
  final DrawerMenu screenIndex;
  final Function(DrawerMenu) callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerMenuModel> drawerMenuList = <DrawerMenuModel>[
    DrawerMenuModel(
        menu: DrawerMenu.HOME, labelName: 'Home', icon: Icon(Icons.home)),
    DrawerMenuModel(
        menu: DrawerMenu.FeedBack,
        labelName: 'FeedBack',
        icon: Icon(Icons.message)),
    DrawerMenuModel(
        menu: DrawerMenu.Help, labelName: 'Help', icon: Icon(Icons.help)),
    DrawerMenuModel(
        menu: DrawerMenu.Share, labelName: 'Share', icon: Icon(Icons.share)),
    DrawerMenuModel(
        menu: DrawerMenu.About, labelName: 'About', icon: Icon(Icons.info)),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(
                            1.0 - (widget.iconAnimationController.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppTheme.grey.withOpacity(0.6),
                                      offset: const Offset(2.0, 4.0),
                                      blurRadius: 8.0)
                                ]),
                            child: RoundedNetImage(
                              "https://jiaozi-tarim.oss-cn-hangzhou.aliyuncs.com/app/109951164143507989.jpg",
                              fit: BoxFit.cover,
                              radius: 60.0,
                            ),
//                            ExtendedImage.network(
//                              "https://jiaozi-tarim.oss-cn-hangzhou.aliyuncs.com/app/109951164143507989.jpg",
//                              fit: BoxFit.cover,
//                              border: Border.all(color: Colors.red, width: 1),
//                              borderRadius: BorderRadius.circular(60.0),
//                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      "Listen2",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.grey,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(height: 1, color: AppTheme.grey.withOpacity(0.6)),
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0.0),
                itemCount: drawerMenuList.length,
                itemBuilder: (BuildContext context, int index) {
                  return drawerInkWell(drawerMenuList[index]);
                }),
          )
        ],
      ),
    );
  }

  Widget drawerInkWell(DrawerMenuModel listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationToScreen(listData.menu);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                  ),
                  const Padding(padding: EdgeInsets.all(4.0)),
                  Icon(listData.icon.icon,
                      color: widget.screenIndex == listData.menu
                          ? Colors.blue
                          : AppTheme.nearlyBlack),
                  const Padding(padding: EdgeInsets.all(4.0)),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: widget.screenIndex == listData.menu
                            ? Colors.blue
                            : AppTheme.nearlyBlack),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ),
            widget.screenIndex == listData.menu
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 20) *
                                (1.0 -
                                    widget.iconAnimationController.value -
                                    1.0),
                            0,
                            0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 20,
                            height: 46,
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(28),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(28),
                                )),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationToScreen(DrawerMenu drawerMenu) async {
    widget.callBackIndex(drawerMenu);
  }
}

enum DrawerMenu { HOME, FeedBack, Help, Share, About }

class DrawerMenuModel {
  DrawerMenuModel({this.labelName = '', this.icon, this.menu});

  String labelName;
  Icon icon;
  DrawerMenu menu;
}
