import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final BoxFit fit;

  const CachedImage(
      {super.key, this.imageUrl, this.radius = 0, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        fit: fit,
        placeholder: (context, url) => const SkeletonAvatar(),
        errorWidget: (context, url, error) => Container(
          color: Colors.red,
        ),
      ),
    );

  }
}
