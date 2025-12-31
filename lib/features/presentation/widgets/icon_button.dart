import 'package:flutter/material.dart';

class MyIconButton extends StatefulWidget {
  const MyIconButton({
    super.key,
    this.duration = const Duration(milliseconds: 200),
    required this.icon,
    this.onPressed,
    required this.width,
    required this.height,
  });
  final Duration duration;
  final Widget icon;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  @override
  State<MyIconButton> createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  double scale = 1.2;
  void _playPaddingAnimation() async {
    setState(() {
      scale = .6;
      Future.delayed(widget.duration).whenComplete(
        () => setState(() {
          scale = 1.2;
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        widget.onPressed?.call();
        _playPaddingAnimation();
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: AnimatedScale(
          scale: scale,
          duration: widget.duration,
          child: widget.icon,
        ),
      ),
    );
  }
}
