import 'package:flutter/material.dart';

import '../common_config/common_style.dart';

/// 添加组件的点击区域
class ExtendedWidget extends StatelessWidget {
  ExtendedWidget(
      {Key key,
      this.child,
      this.onTap,
      this.onDoubleTap,
      this.padding = const EdgeInsets.all(5),
      this.borderRadius = BorderRadius.zero,
      this.color = CommonColors.transparent})
      : super(key: key);
  final Widget child;
  final Function onTap;
  final Function onDoubleTap;
  final EdgeInsetsGeometry padding;
  final Color color;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap?.call();
      },
      onDoubleTap: () {
        onDoubleTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: borderRadius,
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}
