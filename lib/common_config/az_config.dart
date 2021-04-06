import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/routers/application.dart';

class AZConfig {
  static const String androidKey = "29a7802c2f9a8ff95136840049f9ef68";
  static const String iosKey = "ff61a335ef8c1bc018ccb49e44b9f7c5";

  static const AZ_USER_ENVIRONMENT_KEY = "AZ_USER_ENVIRONMENT_KEY"; //当前环境
  static const AZ_TOKEN_KEY = "AZ_TOKEN_KEY"; //token
  static const PAGE_SIZE = 10;
  static const double tabbarHeight = 56;
  static double screenHeight() {
    return MediaQuery.of(Application.navigatorKey.currentContext).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Application.navigatorKey.currentContext).size.width;
  }

  // iphoneX下巴高度
  static double iphoneXBottomHeight() {
    return MediaQuery.of(Application.navigatorKey.currentContext)
        .padding
        .bottom;
  }

  // iphoneX刘海高度
  static double iphoneXTopHeight() {
    return MediaQuery.of(Application.navigatorKey.currentContext).padding.top;
  }
}

// 网络环境
enum NetEnvironment {
  Dev,
  Test,
  Release,
}
