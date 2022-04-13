import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_admin_app/page/debug/debug_label.dart';
import 'package:flutter_admin_app/page/main/main_screen.dart';
import 'package:flutter_admin_app/page/user/login/login.page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_admin_app/common/event/http_error_event.dart';
import 'package:flutter_admin_app/common/event/index.dart';
import 'package:flutter_admin_app/common/localization/default_localizations.dart';
import 'package:flutter_admin_app/common/localization/_localizations_delegate.dart';
import 'package:flutter_admin_app/page/photoview_page.dart';
import 'package:flutter_admin_app/redux/global_state.dart';
import 'package:flutter_admin_app/model/User.dart';
import 'package:flutter_admin_app/common/style/_style.dart';
import 'package:flutter_admin_app/common/utils/common_utils.dart';
import 'package:flutter_admin_app/page/home/home_page.dart';
import 'package:flutter_admin_app/page/welcome_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_admin_app/common/net/code.dart';

import 'common/event/index.dart';
import 'common/utils/navigator_utils.dart';

class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp>
    with HttpErrorListener, NavigatorObserver {
  /// 创建Store，引用 GState 中的 appReducer 实现 Reducer 方法
  /// initialState 初始化 State
  final store = Store<GState>(
    appReducer,

    ///拦截器
    middleware: middleware,

    ///初始化数据
    initialState: GState(
        userInfo: User.empty(),
        login: false,
        themeData: CommonUtils.getThemeData(TColors.primarySwatch),
        locale: const Locale('zh', 'CH')),
  );

  ColorFilter greyscale = const ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      /// 通过 with NavigatorObserver ，在这里可以获取可以往上获取到
      /// MaterialApp 和 StoreProvider 的 context
      /// 还可以获取到 navigator;
      /// 比如在这里增加一个监听，如果 token 失效就退回登陆页。
      navigator!.context;
      navigator;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 使用 flutter_redux 做全局状态共享
    /// 通过 StoreProvider 应用 store
    return StoreProvider(
      store: store,
      child: StoreBuilder<GState>(builder: (context, store) {
        ///使用 StoreBuilder 获取 store 中的 theme 、locale
        store.state.platformLocale = WidgetsBinding.instance!.window.locale;
        Widget app = MaterialApp(

            ///多语言实现代理
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              TLocalizationsDelegate.delegate,
            ],
            supportedLocales: [
              store.state.locale ?? store.state.platformLocale!
            ],
            locale: store.state.locale,
            theme: store.state.themeData,
            navigatorObservers: [this],

            ///命名式路由
            /// "/" 和 MaterialApp 的 home 参数一个效果
            ///⚠️ 这里的 name调用，里面 pageContainer 方法有一个 MediaQuery.of(context).copyWith(textScaleFactor: 1),
            ///⚠️ 而这里的 context 用的是 WidgetBuilder 的 context  ～
            ///⚠️ 所以 MediaQuery.of(context) 这个 InheritedWidget 就把这个 context “登记”到了 Element 的内部静态 _map 里。
            ///⚠️ 所以键盘弹出来的时候，触发了顶层的 MediaQueryData 发生变化，自然就触发了“登记”过的 context 的变化
            ///⚠️ 比如 LoginPage 、HomePage ····
            ///⚠️ 所以比如你在 搜索页面 键盘弹出时，下面的 HomePage.sName 对应的 WidgetBuilder 会被触发
            ///⚠️ 这个是我故意的，如果不需要，可以去掉 pageContainer 或者不要用这里的 context
            routes: {
              WelcomePage.sName: (context) {
                _context = context;
                DebugLabel.showDebugLabel(context);
                return WelcomePage();
              },
              HomePage.sName: (context) {
                _context = context;
                return NavigatorUtils.pageContainer(HomePage(), context);
              },
              MainScreen.sName: (context) {
                _context = context;
                return NavigatorUtils.pageContainer(MainScreen(), context);
              },

              LoginPage.sName: (context) {
                _context = context;
                return NavigatorUtils.pageContainer(const LoginPage(), context);
              },

              ///使用 ModalRoute.of(context).settings.arguments; 获取参数
              PhotoViewPage.sName: (context) {
                return PhotoViewPage();
              },
            });

        if (store.state.grey) {
          ///mode one
          app = ColorFiltered(
              colorFilter:
                  const ColorFilter.mode(Colors.grey, BlendMode.saturation),
              child: app);

          ///mode tow
          // app = ColorFiltered(
          //     colorFilter: greyscale,
          //     child: app);
        }

        return app;
      }),
    );
  }
}

mixin HttpErrorListener on State<FlutterReduxApp> {
  StreamSubscription? stream;

  ///这里为什么用 _context 你理解吗？
  ///因为此时 State 的 context 是 FlutterReduxApp 而不是 MaterialApp
  ///所以如果直接用 context 是会获取不到 MaterialApp 的 Localizations 哦。
  late BuildContext _context;

  @override
  void initState() {
    super.initState();

    ///Stream演示event bus
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream!.cancel();
      stream = null;
    }
  }

  ///网络错误提醒
  errorHandleFunction(int? code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        showToast(TLocalizations.i18n(_context)!.network_error);
        break;
      case 401:
        showToast(TLocalizations.i18n(_context)!.network_error_401);
        break;
      case 403:
        showToast(TLocalizations.i18n(_context)!.network_error_403);
        break;
      case 404:
        showToast(TLocalizations.i18n(_context)!.network_error_404);
        break;
      case 422:
        showToast(TLocalizations.i18n(_context)!.network_error_422);
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        showToast(TLocalizations.i18n(_context)!.network_error_timeout);
        break;
      case Code.GITHUB_API_REFUSED:
        //Github API 异常
        showToast(TLocalizations.i18n(_context)!.github_refused);
        break;
      default:
        showToast(TLocalizations.i18n(_context)!.network_error_unknown +
            " " +
            message);
        break;
    }
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);
  }
}
