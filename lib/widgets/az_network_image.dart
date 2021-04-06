import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'az_empty_image_view.dart';

const emptyIcon = "lib/sources/images/image_placeholder.png";
const defaultAvatar = "lib/sources/images/default_avatar.png";

class AZNetworkImage extends StatelessWidget {
  AZNetworkImage({
    Key key,
    @required this.imageUrl,
    this.emptyAsset,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.useOldImageOnUrlChange = true,
    this.userAvatar = false,
    this.memCacheHeight,
    this.memCacheWidth,
  }) : super(key: key);

  final String imageUrl;

  final String emptyAsset;

  final double width;

  final double height;

  final BoxFit fit;

  final AlignmentGeometry alignment;

  final bool userAvatar;

  final int memCacheWidth;
  final int memCacheHeight;

  /// When set to true it will animate from the old image to the new image
  /// if the url changes.
  final bool useOldImageOnUrlChange;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: ValueKey<String>(this.imageUrl),
      imageUrl: this.imageUrl ?? "",
      width: this.width,
      height: this.height,
      fit: this.fit,
      alignment: this.alignment,
      useOldImageOnUrlChange: this.useOldImageOnUrlChange,
      placeholder: (_, __) =>
          AzEmptyImageView(emptyAsset: userAvatar ? defaultAvatar : emptyAsset),
      errorWidget: (_, __, ___) =>
          AzEmptyImageView(emptyAsset: userAvatar ? defaultAvatar : emptyAsset),
      memCacheHeight: memCacheHeight,
      memCacheWidth: memCacheWidth,
    );
  }
}
