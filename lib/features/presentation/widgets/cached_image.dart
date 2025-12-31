import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyCachedImage extends StatefulWidget {
  const MyCachedImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.duration,
  });
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Duration? duration;

  @override
  State<MyCachedImage> createState() => _MyCachedImageState();
}

class _MyCachedImageState extends State<MyCachedImage> {
  double containerWidth = 0;
  double containerHeight = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      containerWidth =
          widget.width ?? 100 + MediaQuery.of(context).size.width * 0.1;
      containerHeight =
          widget.height ?? 100 + MediaQuery.of(context).size.height * 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration ?? Duration(milliseconds: 200),
      width: containerWidth,
      height: containerHeight,
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        fit: widget.fit ?? BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
