import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/common_utils/toast_util.dart';
import 'package:flutter_fenxiao/generated/l10n.dart';

import 'package:flutter_fenxiao/models/user.dart';
import 'package:intl/intl.dart';

class AppProvider with ChangeNotifier {
  User currentUser;

  void getUserInfo() {}

  void accountLogin({String tel, String pwd}) {}

  //  退出登陆
  void logout() {
    currentUser = null;
  }

  Locale _locale = Locale("zh");
  Locale get locale =>
      _locale != null ? _locale : Locale(Intl.getCurrentLocale());
  //修改App语言
  void changeAppLanguage(Locale locale) {
    String lang = locale.languageCode.split("_")[0];
    if (lang == "en") {
      // 目前不区分各种英文
      S.load(locale);
      _locale = locale;
    } else {
      S.load(Locale("zh"));
      _locale = Locale("zh");
    }
    notifyListeners();
  }
}
