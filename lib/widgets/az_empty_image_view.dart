import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fenxiao/common_config/common_style.dart';

const String emptyIcon = "lib/sources/images/image_placeholder.png";

///网络图片缺省页面，父组件需要给宽高
class AzEmptyImageView extends StatelessWidget {
  const AzEmptyImageView({Key key, this.emptyAsset}) : super(key: key);

  final String emptyAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CommonColors.background,
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(emptyAsset ?? emptyIcon),
      ),
    );
  }
}
