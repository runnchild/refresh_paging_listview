import 'package:flutter/material.dart';

class EmptyConfig {
  final String? text, btnText, image;
  final bool btnVisible;
  final VoidCallback? onPress;
  final Widget? imageView, textView, body,button;
  final double? centerTop, centerBottom;
  final Color backgroundColor;

  EmptyConfig({
    this.text,
    this.btnText,
    this.image,
    this.btnVisible = true,
    this.onPress,
    this.imageView,
    this.textView,
    this.body,
    this.button,
    this.centerTop,
    this.centerBottom,
    this.backgroundColor = Colors.white,
  });
}
