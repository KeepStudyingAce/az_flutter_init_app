import 'dart:math';
import 'package:flutter/material.dart';

/// An indicator showing the currently selected page of a PageController
class AZDotsIndicator extends AnimatedWidget {
  AZDotsIndicator({
    this.controller,
    this.itemCount,
    // this.onPageSelected,
    this.color: Colors.grey,
    this.activeColor: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this AZDotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  // final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  /// The activeColor of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color activeColor;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 1;

  // The distance between the center of each dot
  static const double _kDotSpacing = 15.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    bool isActive = (controller.page ?? controller.initialPage) == index;
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: isActive ? activeColor : color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => controller.animateToPage(
                index,
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
