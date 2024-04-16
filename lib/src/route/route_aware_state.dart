import 'package:flutter/material.dart';
import 'package:refresh_paging_listview/refresh_paging_listview.dart';

final MyRouteObserver<ModalRoute<void>> myRouteObserver =
    MyRouteObserver<ModalRoute<void>>();

abstract class RouteAwareState<T extends StatefulWidget> extends State<T>
    with MyRouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var route = ModalRoute.of(context);
    if (route != null) {
      myRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    myRouteObserver.unsubscribe(this);
    super.dispose();
  }
}
