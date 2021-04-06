import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/common_config/az_config.dart';
import 'package:flutter_fenxiao/routers/app_router.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  String bg = 'lib/sources/images/bg_welcome.png';
  @override
  void initState() {
    this.checkToken();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      bg,
      width: AZConfig.screenWidth(),
      height: AZConfig.screenHeight(),
      fit: BoxFit.fill,
    );
  }

  ///校验Token再跳转
  void checkToken() async {
    // String token = await LocalStorage.get(AZConfig.AZ_TOKEN_KEY);
    // if (token != null && token.length > 0) {
    //   AZGlobal.savaToken(token);
    Future.delayed(
        Duration(
          milliseconds: 2000,
        ), () {
      AppRouter.goRootTab(context);
    });

    //   //获取用户信息
    // } else {
    //   AppRouter.goLoginPage(context);
    // }
  }
}
