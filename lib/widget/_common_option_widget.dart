import 'package:flutter/material.dart';
import 'package:flutter_admin_app/common/localization/default_localizations.dart';
import 'package:flutter_admin_app/common/style/_style.dart';
import 'package:flutter_admin_app/common/utils/common_utils.dart';
import 'package:share/share.dart';

class GSYCommonOptionWidget extends StatelessWidget {
  final List<GSYOptionModel>? otherList;

  final String? url;

  GSYCommonOptionWidget({this.otherList, String? url})
      : this.url = (url == null) ? TConstant.app_default_share_url : url;

  _renderHeaderPopItem(List<GSYOptionModel> list) {
    return PopupMenuButton<GSYOptionModel>(
      child: const Icon(TICons.MORE),
      onSelected: (model) {
        model.selected(model);
      },
      itemBuilder: (BuildContext context) {
        return _renderHeaderPopItemChild(list);
      },
    );
  }

  _renderHeaderPopItemChild(List<GSYOptionModel> data) {
    List<PopupMenuEntry<GSYOptionModel>> list = [];
    for (GSYOptionModel item in data) {
      list.add(PopupMenuItem<GSYOptionModel>(
        value: item,
        child: Text(item.name),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<GSYOptionModel> constList = [
      GSYOptionModel(TLocalizations.i18n(context)!.option_web,
          TLocalizations.i18n(context)!.option_web, (model) {
        CommonUtils.launchOutURL(url, context);
      }),
      GSYOptionModel(TLocalizations.i18n(context)!.option_copy,
          TLocalizations.i18n(context)!.option_copy, (model) {
        CommonUtils.copy(url ?? "", context);
      }),
      GSYOptionModel(TLocalizations.i18n(context)!.option_share,
          TLocalizations.i18n(context)!.option_share, (model) {
        Share.share(
            TLocalizations.i18n(context)!.option_share_title + (url ?? ""));
      }),
    ];
    var list = [...constList, ...?otherList];
    return _renderHeaderPopItem(list);
  }
}

class GSYOptionModel {
  final String name;
  final String value;
  final PopupMenuItemSelected<GSYOptionModel> selected;

  GSYOptionModel(this.name, this.value, this.selected);
}
