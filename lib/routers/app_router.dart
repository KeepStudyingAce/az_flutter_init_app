import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/pages/login_page.dart';
import 'package:flutter_fenxiao/pages/root_tab.dart';
import 'package:flutter_fenxiao/pages/welcome_page.dart';
import 'i_router_provider.dart';
import 'navigator_util.dart';

class AppRouter implements IRouterProvider {
  /// 欢迎页
  static String _welcome = "/";

  /// 根RootTab
  static String _rootTab = "/_rootTab";

  static void goRootTab(BuildContext context) {
    NavigatorUtil.pushTo(
      context,
      _rootTab,
      replace: true,
      clearStack: true,
      transition: TransitionType.fadeIn,
    );
  }

  /// LoginPage
  static String loginPage = "/login";

  static void goLoginPage(BuildContext context) {
    NavigatorUtil.pushTo(
      context,
      loginPage,
      replace: true,
      clearStack: true,
      transition: TransitionType.fadeIn,
    );
  }

  @override
  void initRouter(FluroRouter router) {
    // 闪屏页面
    router.define(
      _welcome,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
            WelcomePage(),
      ),
    );
    // 根Root
    router.define(
      _rootTab,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
            RootTab(),
      ),
    );
    // 登陆页面
    router.define(
      loginPage,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
            LoginPage(),
      ),
    );
  }
}
