import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_app/common/localization/default_localizations.dart';
import 'package:flutter_admin_app/common/style/_style.dart';
import 'package:flutter_admin_app/common/utils/navigator_utils.dart';
import 'package:flutter_admin_app/page/dynamic_page.dart';
import 'package:flutter_admin_app/page/my_page.dart';
import 'package:flutter_admin_app/page/trend_page.dart';
import 'package:flutter_admin_app/widget/gsy_tabbar_widget.dart';
import 'package:flutter_admin_app/widget/_title_bar.dart';
import 'package:flutter_admin_app/page/home/home_drawer.dart';

/**
 * 主页
 */
class HomePage extends StatefulWidget {
  static final String sName = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<DynamicPageState> dynamicKey = GlobalKey();
  final GlobalKey<TrendPageState> trendKey = GlobalKey();
  final GlobalKey<MyPageState> myKey = GlobalKey();

  /// 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    ///如果是 android 回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = const AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }

    return Future.value(false);
  }

  _renderTab(icon, text) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Icon(icon, size: 16.0), Text(text)],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(TICons.MAIN_DT, TLocalizations.i18n(context)!.home_dynamic),
      _renderTab(TICons.MAIN_QS, TLocalizations.i18n(context)!.home_trend),
      _renderTab(TICons.MAIN_MY, TLocalizations.i18n(context)!.home_my),
    ];

    ///增加返回按键监听
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: GSYTabBarWidget(
        drawer: HomeDrawer(),
        type: TabType.bottom,
        tabItems: tabs,
        tabViews: [
          DynamicPage(key: dynamicKey),
          TrendPage(key: trendKey),
          MyPage(key: myKey),
        ],
        onDoublePress: (index) {
          // switch (index) {
          //   case 0:
          //     dynamicKey.currentState!.scrollToTop();
          //     break;
          //   case 1:
          //     trendKey.currentState!.scrollToTop();
          //     break;
          //   case 2:
          //     myKey.currentState!.scrollToTop();
          //     break;
          // }
        },
        backgroundColor: TColors.primarySwatch,
        indicatorColor: TColors.white,
        title: TitleBar(
          TLocalizations.of(context)!.currentLocalized!.app_name,
          iconData: TICons.MAIN_SEARCH,
          needRightLocalIcon: true,
          onRightIconPressed: (centerPosition) {
            // NavigatorUtils.goSearchPage(context, centerPosition);
          },
        ),
      ),
    );
  }
}
