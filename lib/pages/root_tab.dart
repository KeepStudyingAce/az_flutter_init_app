import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/app_provider.dart';
import 'package:flutter_fenxiao/common_config/common_style.dart';
import 'package:flutter_fenxiao/generated/l10n.dart';
import 'package:flutter_fenxiao/pages/cart/cart_page.dart';
import 'package:flutter_fenxiao/pages/category/category_page.dart';
import 'package:flutter_fenxiao/pages/home/home_page.dart';
import 'package:flutter_fenxiao/pages/mine/mine_page.dart';
import 'package:flutter_fenxiao/widgets/tabbar/az_tabbar_item.dart';
import 'package:flutter_fenxiao/widgets/tabbar/tabbar_background_bar.dart';
import 'package:provider/provider.dart';

String tabHomeNor = "lib/sources/images/tab_home_nor.png";
String tabHomeSel = "lib/sources/images/tab_home_sel.png";

String tabCategoryNor = "lib/sources/images/tab_category_nor.png";
String tabCategorySel = "lib/sources/images/tab_category_sel.png";

String tabCartNor = "lib/sources/images/tab_cart_nor.png";
String tabCartSel = "lib/sources/images/tab_cart_sel.png";

String tabMineNor = "lib/sources/images/tab_mine_nor.png";
String tabMineSel = "lib/sources/images/tab_mine_sel.png";

class RootTab extends StatefulWidget {
  RootTab({Key key}) : super(key: key);

  @override
  _RootTabState createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  List<Widget> _pageList = [];
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    _pageList
      ..add(HomePage())
      ..add(CategoryPage())
      ..add(CartPage())
      ..add(MinePage());
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _pageList,
        ),
        bottomNavigationBar: TabbarBackgroundBar(
          items: [
            AZTabbarItem(
              icon: Image.asset(tabHomeNor),
              title: Text(
                S.of(context).tab_home,
                style: TextStyle(
                  fontSize: 10,
                  color: _currentIndex == 0
                      ? CommonColors.black
                      : CommonColors.black50,
                  fontWeight: _currentIndex == 0
                      ? CommonFont.fontWeightMiddle
                      : CommonFont.fontWeightRegular,
                ),
              ),
              activeIcon: Image.asset(tabHomeSel),
            ),
            AZTabbarItem(
              icon: Image.asset(tabCategoryNor),
              title: Text(
                S.of(context).tab_category,
                style: TextStyle(
                  fontSize: 10,
                  color: _currentIndex == 1
                      ? CommonColors.black
                      : CommonColors.black50,
                  fontWeight: _currentIndex == 1
                      ? CommonFont.fontWeightMiddle
                      : CommonFont.fontWeightRegular,
                ),
              ),
              activeIcon: Image.asset(tabCartSel),
            ),
            AZTabbarItem(
              icon: Image.asset(tabCartNor),
              title: Text(
                S.of(context).tab_cart,
                style: TextStyle(
                  fontSize: 10,
                  color: _currentIndex == 2
                      ? CommonColors.black
                      : CommonColors.black50,
                  fontWeight: _currentIndex == 2
                      ? CommonFont.fontWeightMiddle
                      : CommonFont.fontWeightRegular,
                ),
              ),
              activeIcon: Image.asset(tabCartSel),
            ),
            AZTabbarItem(
              icon: Image.asset(tabMineNor),
              title: Text(
                S.of(context).tab_mine,
                style: TextStyle(
                  fontSize: 10,
                  color: _currentIndex == 3
                      ? CommonColors.black
                      : CommonColors.black50,
                  fontWeight: _currentIndex == 3
                      ? CommonFont.fontWeightMiddle
                      : CommonFont.fontWeightRegular,
                ),
              ),
              activeIcon: Image.asset(tabMineSel),
            ),
          ],
          onChange: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
              String lang =
                  context.read<AppProvider>().locale.languageCode.split("_")[0];
              if (lang == "en") {
                // 目前不区分各种英文
                S.load(Locale("zh"));
                context.read<AppProvider>().changeAppLanguage(Locale("zh"));
              } else {
                S.load(Locale("en"));
                context.read<AppProvider>().changeAppLanguage(Locale("en"));
              }
            });
          },
        ));
  }
}
