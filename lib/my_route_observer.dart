import 'package:flutter/material.dart';
import 'route_aware.dart';

class MyRouteObserver<R extends Route<dynamic>> extends NavigatorObserver {
  final Map<R, Set<MyRouteAware>> _listeners = <R, Set<MyRouteAware>>{};

  /// Whether this observer is managing changes for the specified route.
  ///
  /// If asserts are disabled, this method will throw an exception.
  bool debugObservingRoute(R route) {
    late bool contained;
    assert(() {
      contained = _listeners.containsKey(route);
      return true;
    }());
    return contained;
  }

  /// Subscribe [routeAware] to be informed about changes to [route].
  ///
  /// Going forward, [routeAware] will be informed about qualifying changes
  /// to [route], e.g. when [route] is covered by another route or when [route]
  /// is popped off the [Navigator] stack.
  void subscribe(MyRouteAware routeAware, R route) {
    assert(routeAware != null);
    assert(route != null);
    final Set<MyRouteAware> subscribers =
        _listeners.putIfAbsent(route, () => <MyRouteAware>{});
    if (subscribers.add(routeAware)) {
      routeAware.didPush();
    }
  }

  /// Unsubscribe [routeAware].
  ///
  /// [routeAware] is no longer informed about changes to its route. If the given argument was
  /// subscribed to multiple types, this will unregister it (once) from each type.
  void unsubscribe(MyRouteAware routeAware) {
    assert(routeAware != null);
    final List<R> routes = _listeners.keys.toList();
    for (final R route in routes) {
      final Set<MyRouteAware>? subscribers = _listeners[route];
      if (subscribers != null) {
        subscribers.remove(routeAware);
        if (subscribers.isEmpty) {
          _listeners.remove(route);
        }
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is R && previousRoute is R) {
      final List<MyRouteAware>? previousSubscribers =
          _listeners[previousRoute]?.toList();

      if (previousSubscribers != null) {
        for (final MyRouteAware routeAware in previousSubscribers) {
          routeAware.didPopNext(route, previousRoute);
        }
      }

      final List<MyRouteAware>? subscribers = _listeners[route]?.toList();

      if (subscribers != null) {
        for (final MyRouteAware routeAware in subscribers) {
          routeAware.didPop(route, previousRoute);
        }
      }
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is R && previousRoute is R) {
      final Set<MyRouteAware>? previousSubscribers = _listeners[previousRoute];

      if (previousSubscribers != null) {
        for (final MyRouteAware routeAware in previousSubscribers) {
          routeAware.didPushNext(route, previousRoute);
        }
      }
    }
  }
}
