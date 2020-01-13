import 'package:flutter/material.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/page/drawer/drawer_user_controller.dart';
import 'package:listen2/page/drawer/home_drawer.dart';
import 'package:listen2/page/home/home_page.dart';

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
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
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
      if (drawerMenu == DrawerMenu.HOME) {
        setState(() {
          screenView = const HomePage();
        });
      } else if (drawerMenu == DrawerMenu.Help) {
        setState(() {
          screenView = const HomePage();
        });
      } else if (drawerMenu == DrawerMenu.FeedBack) {
        setState(() {
          screenView = const HomePage();
        });
      } else if (drawerMenu == DrawerMenu.About) {
        setState(() {
          screenView = const HomePage();
        });
      } else {
        //do in your way......
      }
    }
  }
}
