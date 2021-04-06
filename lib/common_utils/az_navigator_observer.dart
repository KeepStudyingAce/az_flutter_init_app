import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/common_config/az_global.dart';

//监听系统跳转
class AZNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (previousRoute != null && previousRoute.settings.name != null) {
      // UMengAnalytics.onPageEnd(previousRoute.settings.name);
    }

    if (route.settings.name != null) {
      AZGlobal.saveCurrentPage(route.settings.name);
      // UMengAnalytics.onPageStart(route.settings.name);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (route.settings.name != null) {
      print("route:${route.settings.name}");
      // UMengAnalytics.onPageEnd(route.settings.name);
    }

    if (previousRoute.settings.name != null) {
      print("previousRoute:${previousRoute.settings.name}");
      AZGlobal.saveCurrentPage(previousRoute.settings.name);
      // UMengAnalytics.onPageStart(previousRoute.settings.name);
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    if (oldRoute.settings.name != null) {
      // UMengAnalytics.onPageEnd(oldRoute.settings.name);
    }

    if (newRoute.settings.name != null) {
      AZGlobal.saveCurrentPage(newRoute.settings.name);
      // UMengAnalytics.onPageStart(newRoute.settings.name);
    }
  }
}
