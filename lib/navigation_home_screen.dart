import 'package:flutter/material.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/page/about/about_page.dart';
import 'package:listen2/page/drawer/drawer_user_controller.dart';
import 'package:listen2/page/drawer/home_drawer.dart';
import 'package:listen2/page/help/help_page.dar.dart';
import 'package:listen2/page/home/home_page.dart';
import 'package:listen2/page/my_play_list/my_play_list_page.dart';
import 'package:listen2/page/share/share_page.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerMenu drawerMenu;
  AnimationController sliderAnimationController;

  @override
  void initState() {
    drawerMenu = DrawerMenu.HOME;
    screenView = const HomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenMenu: drawerMenu,
            drawerWidth: (MediaQuery.of(context).size.width * 0.75).toInt(),
            animationController: (AnimationController animationController) {
              sliderAnimationController = animationController;
            },
            onDrawerCall: (DrawerMenu drawerMenu) {
              changeIndex(drawerMenu);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerMenu drawerMenuData) {
    if (drawerMenu != drawerMenuData) {
      drawerMenu = drawerMenuData;
      switch (drawerMenu) {
        case DrawerMenu.HOME:
          setState(() {
            screenView = const HomePage();
          });
          break;
        case DrawerMenu.MyPlayList:
          setState(() {
            screenView = const MyPlayListPage();
          });
          break;
        case DrawerMenu.Help:
          setState(() {
            screenView = const HelpPage();
          });
          break;
        case DrawerMenu.Share:
          setState(() {
            screenView = const SharePage();
          });
          break;
        case DrawerMenu.About:
          setState(() {
            screenView = const AboutPage();
          });
          break;
      }
    }
  }
}
