import 'package:flutter/material.dart';

import 'my_route_observer.dart';
import 'route_aware.dart';

final MyRouteObserver<ModalRoute<void>> myRouteObserver =
MyRouteObserver<ModalRoute<void>>();

abstract class RouteAwareState<T extends StatefulWidget> extends State<T>
    with MyRouteAware {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    myRouteObserver.unsubscribe(this);
    super.dispose();
  }
}
