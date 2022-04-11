import 'package:flutter/material.dart';
import 'package:flutter_admin_app/common/net/interceptors/log_interceptor.dart';
import 'package:flutter_admin_app/common/style/_style.dart';

class ErrorPage extends StatefulWidget {
  final String errorMessage;
  final FlutterErrorDetails details;

  ErrorPage(this.errorMessage, this.details);

  @override
  ErrorPageState createState() => ErrorPageState();
}

class ErrorPageState extends State<ErrorPage> {
  static List<Map<String, dynamic>?> sErrorStack = [];
  static List<String?> sErrorName = [];

  final TextEditingController textEditingController = TextEditingController();

  addError(FlutterErrorDetails details) {
    try {
      var map = Map<String, dynamic>();
      map["error"] = details.toString();
      LogsInterceptors.addLogic(
          sErrorName, details.exception.runtimeType.toString());
      LogsInterceptors.addLogic(sErrorStack, map);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;
    return Container(
      color: TColors.primaryValue,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: width,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            gradient:
                RadialGradient(tileMode: TileMode.mirror, radius: 0.1, colors: [
              Colors.white.withAlpha(10),
              TColors.primaryValue.withAlpha(100),
            ]),
            borderRadius: BorderRadius.all(Radius.circular(width / 2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Image(
                  image: AssetImage(TICons.DEFAULT_USER_ICON),
                  width: 90.0,
                  height: 90.0),
              const SizedBox(
                height: 11,
              ),
              const Material(
                child: Text(
                  "Error Occur",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                color: TColors.primaryValue,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: ButtonStyleButton.allOrNull<Color>(
                          TColors.white.withAlpha(100)),
                    ),
                    onPressed: () {
                      // String content = widget.errorMessage;
                      // textEditingController.text = content;
                      // CommonUtils.showEditDialog(
                      //     context,
                      //     TLocalizations.i18n(context)!.home_reply,
                      //     (title) {}, (res) {
                      //   content = res;
                      // }, () {
                      //   if (content.length == 0) {
                      //     return;
                      //   }
                      //   CommonUtils.showLoadingDialog(context);
                      //   IssueDao.createIssueDao("CarGuo", "flutter_admin_app", {
                      //     "title": TLocalizations.i18n(context)!.home_reply,
                      //     "body": content
                      //   }).then((result) {
                      //     Navigator.pop(context);
                      //     Navigator.pop(context);
                      //   });
                      // },
                      //     titleController: TextEditingController(),
                      //     valueController: textEditingController,
                      //     needTitle: false);
                    },
                    child: const Text("Report"),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: ButtonStyleButton.allOrNull<Color>(
                            Colors.white.withAlpha(100)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Back")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
