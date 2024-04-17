import 'package:flutter/material.dart';

class EmptyConfig {
  /// 在有header或者footer的情况下，列表数据为空时是否显示EmptyView
  final bool showEmptyViewWhenListEmpty;

  final String? text, btnText, image;
  final bool btnVisible;

  final Widget? imageView, textView, button;
  final Color backgroundColor;

  VoidCallback? onPress;

  EmptyConfig({
    this.text,
    this.btnText,
    this.image,
    this.btnVisible = true,
    this.imageView,
    this.textView,
    this.button,
    this.backgroundColor = Colors.white,
    this.showEmptyViewWhenListEmpty = true,
  });

  EmptyConfig copyOf({
    String? text,
    String? btnText,
    String? image,
    bool? btnVisible,
    VoidCallback? onPress,
    Widget? imageView,
    Widget? textView,
    Widget? body,
    Widget? button,
    double? centerTop,
    double? centerBottom,
    Color? backgroundColor,
    bool? showEmptyViewWhenListEmpty,
  }) {
    return EmptyConfig(
      text: text ?? this.text,
      btnText: btnText ?? this.btnText,
      image: image ?? this.image,
      btnVisible: btnVisible ?? this.btnVisible,
      imageView: imageView ?? this.imageView,
      textView: textView ?? this.textView,
      button: button ?? this.button,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      showEmptyViewWhenListEmpty: showEmptyViewWhenListEmpty ?? this.showEmptyViewWhenListEmpty,
    );
  }
}
