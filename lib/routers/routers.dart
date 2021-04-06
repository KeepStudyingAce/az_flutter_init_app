import 'package:fluro/fluro.dart';

import 'app_router.dart';
import 'i_router_provider.dart';

class Routers {
  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(FluroRouter router) {
    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(AppRouter());


    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
