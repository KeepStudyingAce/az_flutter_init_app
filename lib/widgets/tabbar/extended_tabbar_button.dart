import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/common_config/common_style.dart';
import 'package:flutter_fenxiao/widgets/tabbar/az_button_painter.dart';
import 'package:flutter_fenxiao/widgets/tabbar/az_tabbar_item.dart';

class ExtendedTabbarButton extends StatefulWidget {
  ExtendedTabbarButton({
    Key key,
    this.itemWidth,
    this.isSelected,
    this.item,
    this.onClick,
  }) : super(key: key);
  final double itemWidth;
  final bool isSelected;
  final AZTabbarItem item;
  final Function onClick;
  @override
  _ExtendedTabbarButtonState createState() => _ExtendedTabbarButtonState();
}

class _ExtendedTabbarButtonState extends State<ExtendedTabbarButton> {
  @override
  Widget build(BuildContext context) {
    double itemWidth = widget.itemWidth;
    double topOffset = widget.isSelected ? -15 : 0;
    double iconTopSpacer = widget.isSelected ? 0 : 3;
    return GestureDetector(
      onTap: () {
        widget.onClick?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        width: itemWidth,
        height: double.maxFinite,
        duration: Duration(milliseconds: 150),
        child: SizedBox(
          width: itemWidth,
          height: kBottomNavigationBarHeight,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: topOffset,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: iconTopSpacer),
                    _makeIconArea(itemWidth),
                    widget.item.title,
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _makeIconArea(double itemWidth) {
    bool isSelected = widget.isSelected;
    double innerBoxSize = itemWidth - 8;
    double innerRadius = isSelected ? 18 : 12;

    return isSelected
        ? CustomPaint(
            painter: AZButtonPainter(
                overHeight: 15,
                color: CommonColors.white,
                shadowColor: Colors.black38),
            child: Container(
              width: innerBoxSize,
              height: 42,
              padding: EdgeInsets.only(top: 8),
              child: CircleAvatar(
                radius: innerRadius,
                backgroundColor: Colors.white,
                child: widget.item.activeIcon,
              ),
            ),
          )
        : Container(
            width: innerBoxSize,
            height: 24,
            child: CircleAvatar(
              radius: innerRadius,
              backgroundColor: Colors.white,
              child: widget.item.icon,
            ),
          );
  }
}
