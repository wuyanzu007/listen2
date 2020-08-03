import 'package:flutter/material.dart';
import 'package:listen2/app_theme.dart';
import 'package:listen2/page/drawer/home_drawer.dart';

class DrawerUserController extends StatefulWidget {
  const DrawerUserController(
      {Key key,
      this.drawerWidth = 250,
      this.onDrawerCall,
      this.screenView,
      this.animationController,
      this.drawerIsOpen,
      this.animatedIconData = AnimatedIcons.arrow_menu,
      this.menuView,
      this.screenMenu})
      : super(key: key);

  //从double修改为int,double在scrollController中会丢失精度,影响抽屉在模拟器中的正常使用
  final int drawerWidth;
  final Function(DrawerMenu) onDrawerCall;
  final Widget screenView;
  final Function(AnimationController) animationController;
  final Function(bool) drawerIsOpen;
  final AnimatedIconData animatedIconData;
  final Widget menuView;
  final DrawerMenu screenMenu;

  @override
  _DrawerUserControllerState createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController>
    with TickerProviderStateMixin {
  ScrollController scrollController;
  AnimationController iconAnimationController;
  AnimationController animationController;

  double scrollOffset = 0.0;
  bool isSetDrawer = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(
        duration: const Duration(milliseconds: 0), vsync: this);
    iconAnimationController.animateTo(1.0,
        duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth.toDouble());
    scrollController
      ..addListener(() {
        if (scrollController.offset <= 0) {
          //偏移量为0,抽屉完全展开
          if (scrollOffset != 1.0) {
            setState(() {
              scrollOffset = 1.0;
              try {
                widget.drawerIsOpen(true);
              } catch (_) {}
            });
          }
          iconAnimationController.animateTo(0.0,
              duration: const Duration(milliseconds: 0), curve: Curves.linear);
        } else if (scrollController.offset > 0 &&
            scrollController.offset < widget.drawerWidth) {
          iconAnimationController.animateTo(
              (scrollController.offset * 100 / (widget.drawerWidth)) / 100,
              duration: const Duration(milliseconds: 0),
              curve: Curves.linear);
        } else if (scrollController.offset >= widget.drawerWidth) {
          //偏移量等于抽屉宽度,抽屉完全关闭
          if (scrollOffset != 0.0) {
            setState(() {
              scrollOffset = 0.0;
              try {
                widget.drawerIsOpen(false);
              } catch (_) {}
            });
          }
          iconAnimationController.animateTo(1.0,
              duration: const Duration(milliseconds: 0), curve: Curves.linear);
        }
      });
    getInitState();
    super.initState();
  }

  Future<bool> getInitState() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 300));
    widget.animationController(iconAnimationController);
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
    scrollController.jumpTo(widget.drawerWidth.toDouble());
    setState(() {
      isSetDrawer = true;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: Opacity(
          opacity: isSetDrawer ? 1 : 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width + widget.drawerWidth,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: widget.drawerWidth.toDouble(),
                  height: MediaQuery.of(context).size.height,
                  child: AnimatedBuilder(
                    animation: iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            scrollController.offset, 0.0, 0.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: widget.drawerWidth.toDouble(),
                          child: HomeDrawer(
                            screenIndex: widget.screenMenu == null
                                ? DrawerMenu.HOME
                                : widget.screenMenu,
                            iconAnimationController: iconAnimationController,
                            callBackIndex: (DrawerMenu menu) {
                              onDrawerClick();
                              widget.onDrawerCall(menu);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey.withOpacity(0.6),
                              blurRadius: 24)
                        ]),
                    child: Stack(
                      children: <Widget>[
                        IgnorePointer(
                          ignoring: scrollOffset == 1 || false,
                          child: widget.screenView == null
                              ? Container(
                                  color: Colors.white,
                                )
                              : widget.screenView,
                        ),
                        scrollOffset == 1.0
                            ? InkWell(
                                onTap: () {
                                  onDrawerClick();
                                },
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top + 8,
                              left: 8),
                          child: SizedBox(
                            width: AppBar().preferredSize.height - 8,
                            height: AppBar().preferredSize.height - 8,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                    AppBar().preferredSize.height),
                                child: Center(
                                    child: widget.menuView != null
                                        ? widget.menuView
                                        : AnimatedIcon(
                                            icon:
                                                widget.animatedIconData != null
                                                    ? widget.animatedIconData
                                                    : AnimatedIcons.arrow_menu,
                                            progress: iconAnimationController,
                                          )),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  onDrawerClick();
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDrawerClick() {
    if (scrollController.offset != 0.0) {
      // 偏移量不等于0 关闭抽屉
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      // 打开抽屉
      scrollController.animateTo(
        widget.drawerWidth.toDouble(),
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
