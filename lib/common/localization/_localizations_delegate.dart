import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_app/common/localization/default_localizations.dart';

/**
 * 多语言代理
 */
class TLocalizationsDelegate extends LocalizationsDelegate<TLocalizations> {
  TLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    ///支持中文和英语
    return true;
  }

  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  @override
  Future<TLocalizations> load(Locale locale) {
    return SynchronousFuture<TLocalizations>(TLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<TLocalizations> old) {
    return false;
  }

  ///全局静态的代理
  static LocalizationsDelegate<TLocalizations> delegate =
      TLocalizationsDelegate();
}
