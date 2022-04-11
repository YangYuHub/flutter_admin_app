import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_admin_app/common/style/_style.dart';
import 'package:flutter_admin_app/widget/_common_option_widget.dart';
import 'package:flutter_admin_app/widget/_title_bar.dart';
import 'package:photo_view/photo_view.dart';

/**
 * 图片预览
 */

class PhotoViewPage extends StatelessWidget {
  static const String sName = "PhotoViewPage";

  PhotoViewPage();

  @override
  Widget build(BuildContext context) {
    final String? url = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.file_download),
          onPressed: () {
            /* CommonUtils.saveImage(url).then((res) {
              if (res != null) {
                Fluttertoast.showToast(msg: res);
                if (Platform.isAndroid) {
                  const updateAlbum = const MethodChannel(
                      'com.shuyu.gsygithub.gsygithubflutter/UpdateAlbumPlugin');
                  updateAlbum.invokeMethod('updateAlbum', {
                    'path': res,
                    'name': CommonUtils.splitFileNameByPath(res)
                  });
                }
              }
            });*/
          },
        ),
        appBar: AppBar(
          title: TitleBar("", rightWidget: GSYCommonOptionWidget(url: url)),
        ),
        body: Container(
          color: Colors.black,
          child: PhotoView(
              imageProvider: NetworkImage(url ?? TICons.DEFAULT_REMOTE_PIC),
              loadingBuilder: (
                BuildContext context,
                ImageChunkEvent? event,
              ) {
                return Container(
                  child: Stack(
                    children: <Widget>[
                      Center(
                          child: Image.asset(TICons.DEFAULT_IMAGE,
                              height: 180.0, width: 180.0)),
                      const Center(
                          child: SpinKitFoldingCube(
                              color: Colors.white30, size: 60.0)),
                    ],
                  ),
                );
              }),
        ));
  }
}
