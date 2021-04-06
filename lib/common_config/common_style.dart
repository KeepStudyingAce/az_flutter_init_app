import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';

class CommonColors {
  // 透明色   a r g b
  static const Color transparent = Color(0x00000000);

  // 默认页面背景色
  static const Color background = Color(0xFFF6F7F8);

  // 分割线颜色
  static const Color separatorColor = Color(0x20000000);

  // 白色
  static const Color white = Color(0xFFFFFFFF);

  //黑色
  static const Color black = Color(0xFF000000);
  static const Color black50 = Color(0x80000000);

  //红色
  static const Color red = Color(0xFFFF0000);

  // 主题颜色
  static const Color themeColor = Color(0xFF1678FF);

  // shadow颜色
  static const Color tabShadowColor = Color(0x0C000000);

  // 蓝色左右渐变色
  static Gradient mainGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF84B8FF), Color(0xFF006BFF)],
  );

  // 渐变色,出参数
  static Gradient getGradientColor(
    List<Color> colors, {
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: colors,
    );
  }

  // 随机颜色
  static getRandomColor() {
    Random t = Random();
    int r = t.nextInt(255);
    int g = t.nextInt(255);
    int b = t.nextInt(255);
    return Color.fromARGB(255, r, g, b);
  }

  ///根据传入颜色以及透明度返回一个颜色 opacity 0-1
  static getColorWithOpacity(Color color, double opacity) {
    return Color.fromRGBO(color.red, color.green, color.blue, opacity);
  }

  //根据Color返回正确的MaterialColor
  static MaterialColor getMaterialColorFrom(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}

class CommonFont {
  /// AppBar标题颜色
  static const appBarTitleSize = 18.0;

  /// 常见字体大小
  static const normalTitleSize = 12.0;

  /// 常规体
  static const fontWeightRegular = FontWeight.normal;

  /// 粗体
  static const fontWeightBold = FontWeight.bold;

  /// 中粗体
  static const fontWeightMiddle = FontWeight.w500;

  /// tabBar专用中粗体
  static final tabBarFontWeightMiddle =
      Platform.isIOS ? FontWeight.w500 : FontWeight.w600;
}
