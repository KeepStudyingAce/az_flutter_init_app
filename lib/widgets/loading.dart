import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/common_config/common_style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const shimmerIcon = "lib/sources/images/refresh_icon.png";
const String refreshIcon = "lib/sources/images/refresh_icon.png";

class Loading {
  // static showToast(String message) {
  //   EasyLoading.instance.textColor = CommonColors.white;
  //   EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
  //   EasyLoading.instance.indicatorColor = CommonColors.white;
  //   EasyLoading.instance.progressColor = CommonColors.themeColor;
  //   EasyLoading.instance.backgroundColor = CommonColors.black55;
  //   EasyLoading.showToast(message, duration: Duration(milliseconds: 1000));
  // }

  static show() {
    //展示loading的时候不允许用户交互
    EasyLoading.instance.userInteractions = false;

    //==========自定义loading动画==========
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    setRingIndicator();
    EasyLoading.show();
  }

  // //类似下拉刷新动画
  // static setShimmerIndicator() {
  //   EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
  //   EasyLoading.instance.indicatorWidget = Shimmer.fromColors(
  //     period: const Duration(milliseconds: 1000),
  //     direction: ShimmerDirection.ltr,
  //     baseColor: CommonColors.transparent,
  //     highlightColor: const Color(0xFF6B3169),
  //     child: Image.asset(
  //       shimmerIcon,
  //     ),
  //   );
  //   EasyLoading.instance.textColor = CommonColors.themeColor50;
  //   EasyLoading.instance.progressColor = CommonColors.themeColor;
  //   EasyLoading.instance.indicatorColor = CommonColors.white;
  //   EasyLoading.instance.backgroundColor = CommonColors.black30;
  // }

  //类似转圈
  static setRingIndicator() {
    EasyLoading.instance.indicatorWidget = Container(
        constraints: BoxConstraints(
          maxWidth: 30,
        ),
        child: SpinKitRing(
          color: CommonColors.white,
          size: 30,
          lineWidth: 3,
        ));
    EasyLoading.instance.textColor = CommonColors.themeColor;
    EasyLoading.instance.progressColor = CommonColors.themeColor;
    EasyLoading.instance.indicatorColor = CommonColors.white;
    EasyLoading.instance.backgroundColor = CommonColors.black;
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}
