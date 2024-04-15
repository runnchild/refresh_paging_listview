import 'package:flutter/material.dart';

mixin MyRouteAware {
  void didRoutePop(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  void didPush() {}

  void didPopNext(Route<dynamic> route, Route<dynamic> previousRoute) {}

  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {}

  void didPushNext(Route<dynamic> route, Route<dynamic> previousRoute) {}
}
