import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    this.hintText,
    this.backgroundColor,
    this.paddingFromEdges,
  });
  final String? hintText;
  final Color? backgroundColor;

  ///We have a padding from edges of the screen, default is 8.0
  final double? paddingFromEdges;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingFromEdges ?? 8.0),
      child: SearchBar(
        hintText: hintText ?? 'Search',
        backgroundColor: backgroundColor != null
            ? WidgetStateProperty.all(backgroundColor)
            : null,
      ),
    );
  }
}
