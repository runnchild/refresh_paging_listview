import 'package:flutter/material.dart';

class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          axisDirection: details.direction,
          color: Colors.transparent,
          showLeading: false,
          showTrailing: false,
          child: child,
        );
      default:
        return child;
    }
  }
}
