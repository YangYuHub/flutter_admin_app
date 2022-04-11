import 'dart:async';

import 'package:flutter_admin_app/common/style/_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_admin_app/common/dao/user_dao.dart';
import 'package:flutter_admin_app/redux/global_state.dart';
import 'package:flutter_admin_app/common/utils/navigator_utils.dart';
import 'package:flutter_admin_app/widget/diff_scale_text.dart';
import 'package:flutter_admin_app/widget/mole_widget.dart';
import 'package:redux/redux.dart';

/**
 * 欢迎页
 * Created by guoshuyu
 * Date: 2018-07-16
 */

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  String text = "";
  double fontSize = 76;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;

    ///防止多次进入
    Store<GState> store = StoreProvider.of(context);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        text = "Welcome";
        fontSize = 60;
      });
    });
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        text = "GSYGithubApp";
        fontSize = 60;
      });
    });
    Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      // UserDao.initUserInfo(store).then((res) {
      //   if (res != null && res.result) {
      //     NavigatorUtils.goHome(context);
      //   } else {
      //     NavigatorUtils.goLogin(context);
      //   }
      //   return true;
      // });
      NavigatorUtils.goHome(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GState>(
      builder: (context, store) {
        double size = 200;
        return Material(
          child: Container(
            color: TColors.white,
            child: Stack(
              children: <Widget>[
                const Center(
                  child: Image(image: AssetImage('static/images/welcome.png')),
                ),
                Align(
                  alignment: const Alignment(0.0, 0.3),
                  child: DiffScaleText(
                    text: text,
                    textStyle: GoogleFonts.akronim().copyWith(
                      color: TColors.primaryDarkValue,
                      fontSize: fontSize,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.0, 0.8),
                  child: Mole(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: size,
                    height: size,
                    child: const FlareActor(
                        "static/file/flare_flutter_logo_.flr",
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fill,
                        animation: "Placeholder"),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
