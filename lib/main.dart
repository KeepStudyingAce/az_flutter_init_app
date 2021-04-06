import 'dart:async';
import 'dart:io';
import 'package:easy_alert/easy_alert.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_fenxiao/app_provider.dart';
import 'package:flutter_fenxiao/common_utils/az_navigator_observer.dart';
import 'package:flutter_fenxiao/generated/l10n.dart';
import 'package:flutter_fenxiao/routers/application.dart';
import 'package:flutter_fenxiao/routers/routers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common_config/common_style.dart';

void main() async {
  //布局线是否展示
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runZonedGuarded(() async {
      runApp(
        AlertProvider(
          child: MultiProvider(
            providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
            child: MaterialApp(
              builder: (BuildContext context, Widget child) {
                return FlutterEasyLoading(child: MyApp());
              },
            ),
          ),
          config: AlertConfig(),
        ),
      );
    }, (Object error, StackTrace stackTrace) {
      print("AZ好货通Error:" +
          error.toString() +
          "===============\nAZ好货通Stack:" +
          stackTrace.toString());
    });
  });

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) {
    final route = FluroRouter();
    Application.rootRouter = route;
    Routers.configureRoutes(route);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      footerTriggerDistance: 30,
      dragSpeedRatio: 0.91,
      headerBuilder: () => MaterialClassicHeader(),
      footerBuilder: () => ClassicFooter(),
      enableLoadingWhenNoData: false,
      shouldFooterFollowWhenNotFull: (state) {
        return false;
      },
      autoLoad: true,
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          // 下面两个不配置，iOS端会报错
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          RefreshLocalizations.delegate,
        ],
        title: 'az好货通',
        locale: context.watch<AppProvider>().locale,
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          primarySwatch:
              CommonColors.getMaterialColorFrom(CommonColors.themeColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: CommonColors.background,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ).copyWith(
          tabBarTheme: TabBarTheme(
              unselectedLabelStyle:
                  TextStyle(fontWeight: CommonFont.fontWeightRegular),
              labelStyle: TextStyle(fontWeight: CommonFont.fontWeightMiddle)),
          textTheme: confirmTextTheme(ThemeData().textTheme),
          accentTextTheme: confirmTextTheme(ThemeData().accentTextTheme),
          primaryTextTheme: confirmTextTheme(ThemeData().primaryTextTheme),
        ),
        onGenerateRoute: Application.rootRouter.generator,
        navigatorKey: Application.navigatorKey,
        navigatorObservers: [AZNavigatorObserver()],
        builder: (context, widget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                boldText: false,
              ),
              child: widget);
        },
        //系统切换语言时候监听
        localeResolutionCallback:
            (Locale _locale, Iterable<Locale> supportedLocales) {
          Locale locale;
          if (S.delegate.isSupported(_locale)) {
            locale = _locale;
          } else {
            // 默认中文
            locale = Locale("zh");
          }
          S.load(locale);
          // context.read<AppProvider>().changeAppLanguage(locale);
          return locale;
        },
      ),
    );
  }

  /// 处理两平台不是默认字体的问题
  confirmTextTheme(TextTheme textTheme) {
    getCopyTextStyle(TextStyle textStyle) {
      return textStyle.copyWith(
          fontFamilyFallback: Platform.isIOS
              ? [
                  // "Alibaba-PuHuiTi",
                  "PingFang SC",
                  ".SF UI Text",
                  ".SF UI Display"
                ]
              : ["Alibaba-PuHuiTi", "Roboto"]);
    }

    return textTheme.copyWith(
      headline1: getCopyTextStyle(textTheme.headline1),
      headline2: getCopyTextStyle(textTheme.headline2),
      headline3: getCopyTextStyle(textTheme.headline3),
      headline4: getCopyTextStyle(textTheme.headline4),
      headline5: getCopyTextStyle(textTheme.headline5),
      headline6: getCopyTextStyle(textTheme.headline6),
      subtitle1: getCopyTextStyle(textTheme.subtitle1),
      subtitle2: getCopyTextStyle(textTheme.subtitle2),
      bodyText1: getCopyTextStyle(textTheme.bodyText1),
      bodyText2: getCopyTextStyle(textTheme.bodyText1),
      caption: getCopyTextStyle(textTheme.caption),
      button: getCopyTextStyle(textTheme.button),
      overline: getCopyTextStyle(textTheme.overline),
    );
  }
}
