import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/common_config/common_style.dart';
import 'package:flutter_fenxiao/common_config/az_config.dart';
import 'package:flutter_fenxiao/routers/navigator_util.dart';
import 'package:flutter_fenxiao/widgets/az_dot_indicator.dart';
import 'package:flutter_fenxiao/widgets/az_empty_image_view.dart';
import 'package:flutter_fenxiao/widgets/extended_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

const backIcon = "lib/sources/images/icon_back_white.png";

class ImageGalleryPage extends StatefulWidget {
  ImageGalleryPage({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    this.photos = const [],
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<String> photos;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _ImageGalleryPageState();
  }
}

class _ImageGalleryPageState extends State<ImageGalleryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // page_view 滚动一页
  void onPageChanged(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置成黑色
      backgroundColor: Colors.black,
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
            height: AZConfig.screenHeight(), width: AZConfig.screenWidth()),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            PageView.builder(
              controller: widget.pageController,
              itemBuilder: (context, index) {
                String itemUrl = widget.photos[index];
                return GestureDetector(
                  onVerticalDragEnd: (detail) {
                    NavigatorUtil.pop(context);
                  },
                  onTap: () {
                    NavigatorUtil.pop(context);
                  },
                  child: PhotoView(
                    imageProvider: CachedNetworkImageProvider(itemUrl),
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained * (0.7),
                    maxScale: PhotoViewComputedScale.covered * 1.5,
                    heroAttributes: PhotoViewHeroAttributes(tag: "$itemUrl"),
                    loadingBuilder: (context, progress) => Center(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black45,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              CommonColors.white),
                          value: progress == null
                              ? null
                              : progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes,
                        ),
                      ),
                    ),
                    loadFailedChild: Container(
                      color: CommonColors.black,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          NavigatorUtil.pop(context);
                        },
                        child: SizedBox(
                          height: 200,
                          child: AzEmptyImageView(),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.photos.length,
              onPageChanged: onPageChanged,
            ),

            Positioned(
              top: AZConfig.iphoneXTopHeight() + 12,
              left: 12,
              child: ExtendedWidget(
                color: CommonColors.black,
                borderRadius: BorderRadius.circular(2),
                onTap: () {
                  NavigatorUtil.pop(context);
                },
                child: Image.asset(backIcon),
              ),
            ),
            // titile 长度为0时隐藏
            Positioned(
              bottom: AZConfig.iphoneXBottomHeight() + 20,
              child: Offstage(
                offstage: widget.photos.length <= 1,
                child: AZDotsIndicator(
                  controller: widget.pageController,
                  itemCount: widget.photos.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
