/*
 * Author: Jpeng
 * Email: peng8350@gmail.com
 * Time:  2019-07-08 10:51
 */
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_fenxiao/common_config/common_style.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:shimmer/shimmer.dart';

class AZShimmerHeader extends RefreshIndicator {
  final Color baseColor, highlightColor;
  final Widget child;
  final Duration period;
  final ShimmerDirection direction;
  final Function outerBuilder;

  AZShimmerHeader({
    @required this.child,
    this.baseColor = Colors.white,
    this.highlightColor = Colors.black,
    this.outerBuilder,
    double height: 30.0,
    this.period = const Duration(milliseconds: 1000),
    this.direction = ShimmerDirection.ltr,
    RefreshStyle refreshStyle: RefreshStyle.Behind,
  }) : super(height: height, refreshStyle: refreshStyle);

  @override
  State<StatefulWidget> createState() {
    return _AZShimmerHeaderState();
  }
}

class _AZShimmerHeaderState extends RefreshIndicatorState<AZShimmerHeader>
    with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _fadeController;

  RefreshStatus newMode = RefreshStatus.idle;
  DateTime beginRefreshingTime;

  @override
  void initState() {
    _scaleController = AnimationController(vsync: this);
    _fadeController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void onOffsetChange(double offset) {
    if (!floating) {
      _scaleController.value = offset / configuration.headerTriggerDistance;
      _fadeController.value = offset / configuration.footerTriggerDistance;
    }
  }

  @override
  void onModeChange(RefreshStatus mode) {
    if (mode == RefreshStatus.refreshing) {
      newMode = mode;
      beginRefreshingTime = DateTime.now();
      return;
    }
    //控制刷新动画必渲染一次 有点问题，控制不了更长时间，待解决
    if (mode == RefreshStatus.completed || mode == RefreshStatus.failed) {
      if (beginRefreshingTime != null) {
        int timeInterval = DateTime.now().millisecondsSinceEpoch -
            beginRefreshingTime.millisecondsSinceEpoch;
        if (timeInterval < widget.period.inMilliseconds) {
          Future.delayed(
              Duration(
                  milliseconds: widget.period.inMilliseconds - timeInterval),
              () {
            setState(() {
              newMode = mode;
            });
          });
          return;
        }
      }
    }
    // newMode = mode;
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    final Widget body = ScaleTransition(
      scale: _scaleController,
      child: FadeTransition(
        opacity: _fadeController,
        child: newMode == RefreshStatus.refreshing
            ? Shimmer.fromColors(
                period: widget.period,
                direction: widget.direction,
                baseColor: widget.baseColor,
                highlightColor: widget.highlightColor,
                child: Center(
                  child: widget.child,
                ),
              )
            : Center(
                child: widget.child,
              ),
      ),
    );
    return widget.outerBuilder != null
        ? widget.outerBuilder(body)
        : Container(
            alignment: prefix0.Alignment.center,
            child: body,
            decoration: prefix0.BoxDecoration(color: CommonColors.background),
          );
  }
}

class ShimmerFooter extends LoadIndicator {
  final Color baseColor, highlightColor;
  final Widget text, failed, noMore;
  final Duration period;
  final ShimmerDirection direction;
  final Function outerBuilder;

  ShimmerFooter(
      {@required this.text,
      this.baseColor = Colors.grey,
      this.highlightColor = Colors.white,
      this.outerBuilder,
      double height: 80.0,
      this.failed,
      this.noMore,
      this.period = const Duration(milliseconds: 1000),
      this.direction = ShimmerDirection.ltr,
      LoadStyle loadStyle: LoadStyle.ShowAlways})
      : super(height: height, loadStyle: loadStyle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShimmerFooterState();
  }
}

class _ShimmerFooterState extends LoadIndicatorState<ShimmerFooter> {
  @override
  Widget buildContent(BuildContext context, LoadStatus mode) {
    // TODO: implement buildContent

    final Widget body = mode == LoadStatus.failed
        ? widget.failed
        : mode == LoadStatus.noMore
            ? widget.noMore
            : mode == LoadStatus.idle
                ? Center(child: widget.text)
                : Shimmer.fromColors(
                    period: widget.period,
                    direction: widget.direction,
                    baseColor: widget.baseColor,
                    highlightColor: widget.highlightColor,
                    child: Center(
                      child: widget.text,
                    ),
                  );
    return widget.outerBuilder != null
        ? widget.outerBuilder(body)
        : Container(
            height: widget.height,
            child: body,
            decoration: prefix0.BoxDecoration(color: Colors.black12),
          );
  }
}
