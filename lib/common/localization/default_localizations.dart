import 'package:flutter/material.dart';
import 'package:flutter_admin_app/common/localization/_string_base.dart';
import 'package:flutter_admin_app/common/localization/_string_en.dart';
import 'package:flutter_admin_app/common/localization/_string_zh.dart';

///自定义多语言实现
class TLocalizations {
  final Locale locale;

  TLocalizations(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///GSYStringEn和GSYStringZh都继承了TStringBase
  static Map<String, TStringBase> _localizedValues = {
    'en': GSYStringEn(),
    'zh': GSYStringZh(),
  };

  TStringBase? get currentLocalized {
    if (_localizedValues.containsKey(locale.languageCode)) {
      return _localizedValues[locale.languageCode];
    }
    return _localizedValues["en"];
  }

  ///通过 Localizations 加载当前的 TLocalizations
  ///获取对应的 TStringBase
  static TLocalizations? of(BuildContext context) {
    return Localizations.of(context, TLocalizations);
  }

  ///通过 Localizations 加载当前的 TLocalizations
  ///获取对应的 TStringBase
  static TStringBase? i18n(BuildContext context) {
    return (Localizations.of(context, TLocalizations) as TLocalizations)
        .currentLocalized;
  }
}
