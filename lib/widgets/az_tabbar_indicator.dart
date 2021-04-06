import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class AZUnderlineTabIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const AZUnderlineTabIndicator({
    this.width,
    this.height = 2,
    this.bottomMargin = 0,
    this.color = Colors.blue,
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
  })  : assert(borderSide != null),
        assert(insets != null);

  final BorderSide borderSide;

  final EdgeInsetsGeometry insets;

  // 自定义的宽度
  final double width;

  // 自定义的高度
  final double height;

  // 自定义的底部距离
  final double bottomMargin;

  final Color color;

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is AZUnderlineTabIndicator) {
      return AZUnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is AZUnderlineTabIndicator) {
      return AZUnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _UnderlinePainter createBoxPainter([VoidCallback onChanged]) {
    return _UnderlinePainter(this, onChanged);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  final AZUnderlineTabIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;
  EdgeInsetsGeometry get insets => decoration.insets;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size;
    final Rect indicator = Rect.fromLTRB(
        rect.left, (-13 )* rect.size.height, rect.right, rect.bottom);
    final Paint paint = borderSide.toPaint()
      ..strokeCap = StrokeCap.round
      ..color = decoration.color;
    canvas.drawArc(indicator, pi * 57 / 128, pi * 14 / 128, false, paint);
    // canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}
