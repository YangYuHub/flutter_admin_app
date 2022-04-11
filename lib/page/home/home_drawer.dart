import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_admin_app/common/config/config.dart';

import 'package:flutter_admin_app/common/local/local_storage.dart';
import 'package:flutter_admin_app/common/localization/default_localizations.dart';
import 'package:flutter_admin_app/model/User.dart';
import 'package:flutter_admin_app/redux/global_state.dart';
import 'package:flutter_admin_app/redux/login_redux.dart';
import 'package:flutter_admin_app/common/style/_style.dart';
import 'package:flutter_admin_app/common/utils/common_utils.dart';
import 'package:flutter_admin_app/common/utils/navigator_utils.dart';
import 'package:flutter_admin_app/widget/gsy_flex_button.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';

/**
 * 主页drawer
 */
class HomeDrawer extends StatelessWidget {
  showAboutDialog(BuildContext context, String? versionName) {
    versionName ??= "Null";
    NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) => AboutDialog(
              applicationName: TLocalizations.i18n(context)!.app_name,
              applicationVersion: TLocalizations.i18n(context)!.app_version +
                  ": " +
                  (versionName ?? ""),
              applicationIcon: Image(
                  image: AssetImage(TICons.DEFAULT_USER_ICON),
                  width: 50.0,
                  height: 50.0),
              applicationLegalese: "http://github.com/CarGuo",
            ));
  }

  showThemeDialog(BuildContext context, Store store) {
    StringList list = [
      TLocalizations.i18n(context)!.home_theme_default,
      TLocalizations.i18n(context)!.home_theme_1,
      TLocalizations.i18n(context)!.home_theme_2,
      TLocalizations.i18n(context)!.home_theme_3,
      TLocalizations.i18n(context)!.home_theme_4,
      TLocalizations.i18n(context)!.home_theme_5,
      TLocalizations.i18n(context)!.home_theme_6,
    ];
    CommonUtils.showCommitOptionDialog(context, list, (index) {
      CommonUtils.pushTheme(store, index);
      LocalStorage.save(Config.THEME_COLOR, index.toString());
    }, colorList: CommonUtils.getThemeListColor());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoreBuilder<GState>(
        builder: (context, store) {
          User user = store.state.userInfo!;
          return Drawer(
            ///侧边栏按钮Drawer
            child: Container(
              ///默认背景
              color: store.state.themeData!.primaryColor,
              child: SingleChildScrollView(
                ///item 背景
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: Material(
                    color: TColors.white,
                    child: Column(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          //Material内置控件
                          accountName: Text(
                            user.login ?? "Robert",
                            style: TConstant.largeTextWhite,
                          ),
                          accountEmail: Text(
                            user.email ?? user.name ?? "robert@gmail.com",
                            style: TConstant.normalTextLight,
                          ),
                          //用户名
                          //用户邮箱
                          currentAccountPicture: GestureDetector(
                            //用户头像
                            onTap: () {},
                            child: CircleAvatar(
                              //圆形图标控件
                              backgroundImage: NetworkImage(
                                  user.avatar_url ?? TICons.DEFAULT_REMOTE_PIC),
                            ),
                          ),
                          decoration: BoxDecoration(
                            //用一个BoxDecoration装饰器提供背景图片
                            color: store.state.themeData!.primaryColor,
                          ),
                        ),
                        ListTile(
                            title: Text(
                              TLocalizations.i18n(context)!.home_change_theme,
                              style: TConstant.normalText,
                            ),
                            onTap: () {
                              showThemeDialog(context, store);
                            }),
                        ListTile(
                            title: Text(
                              TLocalizations.i18n(context)!
                                  .home_change_language,
                              style: TConstant.normalText,
                            ),
                            onTap: () {
                              CommonUtils.showLanguageDialog(context);
                            }),
                        ListTile(
                            title: GSYFlexButton(
                              text: TLocalizations.i18n(context)!.Login_out,
                              color: Colors.redAccent,
                              textColor: TColors.textWhite,
                              onPress: () {
                                store.dispatch(LogoutAction(context));
                              },
                            ),
                            onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
