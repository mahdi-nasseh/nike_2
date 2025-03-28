import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoadingService extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;
  const ImageLoadingService(
      {super.key, required this.imageUrl, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      errorWidget: (context, url, error) => Text(
          "خطا در بارگزاری تصویر"),
    );

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: image,
    );
  }
}
