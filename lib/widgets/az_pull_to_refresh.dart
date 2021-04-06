import 'package:flutter/cupertino.dart';
import 'package:flutter_fenxiao/common_config/common_style.dart';
import 'package:flutter_fenxiao/widgets/az_shimmer_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const shimmerIcon = "lib/sources/images/refresh_icon.png";

class AZPullRefresh extends StatefulWidget {
  AZPullRefresh({
    Key key,
    this.refreshController,
    this.onLoading,
    this.onRefresh,
    this.padding = const EdgeInsets.all(0),
    this.child,
    this.refreshStyle: RefreshStyle.Behind,
  }) : super(key: key);

  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final EdgeInsetsGeometry padding;
  final RefreshStyle refreshStyle;
  @required
  final Widget child;
  @required
  final RefreshController refreshController;

  @override
  _AZPullRefreshState createState() => _AZPullRefreshState();
}

class _AZPullRefreshState extends State<AZPullRefresh> {
  double currentScrollHeight = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: this.widget.padding,
        child: SmartRefresher(
          enablePullDown: widget.onRefresh != null,
          enablePullUp: widget.onLoading != null,
          header: AZShimmerHeader(
            refreshStyle: this.widget.refreshStyle,
            baseColor: CommonColors.themeColor,
            highlightColor: CommonColors.themeColor,
            child: Image.asset(
              shimmerIcon,
            ),
          ),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              TextStyle bottomStyle =
                  TextStyle(fontSize: 12, color: CommonColors.red);
              if (mode == LoadStatus.idle) {
                body = Text("上拉加载", style: bottomStyle);
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败", style: bottomStyle);
              } else if (mode == LoadStatus.canLoading) {
                body = Text("松手刷新", style: bottomStyle);
              } else {
                body = Text(
                  "～我是有底线的～",
                  style: bottomStyle,
                );
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          controller: this.widget.refreshController,
          onRefresh: () {
            this.widget.onRefresh?.call();
          },
          onLoading: () {
            this.widget.onLoading?.call();
          },
          child: this.widget.child,
        ));
  }
}
