import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/common_config/az_config.dart';
import 'package:flutter_fenxiao/common_config/common_style.dart';
import 'package:flutter_fenxiao/widgets/tabbar/az_tabbar_item.dart';
import 'package:flutter_fenxiao/widgets/tabbar/extended_tabbar_button.dart';

class TabbarBackgroundBar extends StatefulWidget {
  TabbarBackgroundBar({Key key, this.onChange, this.items}) : super(key: key);
  final Function(int) onChange;
  final List<AZTabbarItem> items;
  @override
  _TabbarBackgroundBarState createState() => _TabbarBackgroundBarState();
}

class _TabbarBackgroundBarState extends State<TabbarBackgroundBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AZConfig.screenWidth(),
      decoration: BoxDecoration(color: CommonColors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, -2),
            color: CommonColors.tabShadowColor,
            blurRadius: 2)
      ]),
      height: kBottomNavigationBarHeight + AZConfig.iphoneXBottomHeight(),
      padding: EdgeInsets.only(
          bottom: AZConfig.iphoneXBottomHeight(), left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _buildButtons(),
      ),
    );
  }

  List<Widget> _buildButtons() {
    List<Widget> buttons = [];
    for (var i = 0; i < widget.items.length; ++i) {
      AZTabbarItem item = widget.items[i];
      buttons.add(_buildButton(item, i));
    }

    return buttons;
  }

  Widget _buildButton(AZTabbarItem button, int index) {
    return ExtendedTabbarButton(
      itemWidth: (AZConfig.screenWidth() - 10) / widget.items.length,
      isSelected: _selectedIndex == index,
      onClick: () {
        setState(() {
          _selectedIndex = index;
        });
        widget.onChange(index);
      },
      item: button,
    );
  }
}
