import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    this.controller,
    this.hintText,
    this.backgroundColor,
    this.paddingFromEdges,
    this.onChanged,
  });
  final TextEditingController? controller;
  final String? hintText;
  final Color? backgroundColor;
  final ValueChanged<String>? onChanged;

  ///We have a padding from edges of the screen, default is 8.0
  final double? paddingFromEdges;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingFromEdges ?? 8.0),
      child: SearchBar(
        controller: controller,
        hintText: hintText ?? 'Search',
        onChanged: onChanged,
        backgroundColor: backgroundColor != null
            ? WidgetStateProperty.all(backgroundColor)
            : null,
      ),
    );
  }
}
