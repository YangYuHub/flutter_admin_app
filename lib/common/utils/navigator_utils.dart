import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_app/page/debug/debug_data_page.dart';
import 'package:flutter_admin_app/page/home/home_page.dart';
import 'package:flutter_admin_app/page/main/main_screen.dart';
import 'package:flutter_admin_app/widget/never_overscroll_indicator.dart';

class NavigatorUtils {
  ///主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  ///Main
  static goMain(BuildContext context) {
    Navigator.pushReplacementNamed(context, MainScreen.sName);
  }

  ///弹出 dialog
  static Future<T?> showGSYDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder? builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(

              ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
                  .copyWith(textScaleFactor: 1),
              child: NeverOverScrollIndicator(
                needOverload: false,
                child: SafeArea(child: builder!(context)),
              ));
        });
  }

  ///Page页面的容器，做一次通用自定义
  static Widget pageContainer(widget, BuildContext context) {
    return MediaQuery(

        ///不受系统字体缩放影响
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: NeverOverScrollIndicator(
          needOverload: false,
          child: widget,
        ));
  }

  ///公共打开方式
  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => pageContainer(widget, context)));
  }

  ///请求数据调试页面
  static goDebugDataPage(BuildContext context) {
    return NavigatorRouter(context, new DebugDataPage());
  }
}
