import 'package:flutter/material.dart';
import 'package:flutter_list/route_aware_state.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'custom_footer.dart';
import 'empty_config.dart';
import 'over_scrollbehavior.dart';

abstract class BaseRefreshList extends StatefulWidget {
  final bool enablePullDown;
  final bool enablePullUp;
  final BaseRefreshController? controller;

  const BaseRefreshList({
    Key? key,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.controller,
  }) : super(key: key);
}

/// 1. 定义了一个泛型类，第一个泛型是列表的数据类型，第二个泛型是继承自BaseRefreshList的类
/// 2. 定义了一个RefreshController，用于控制刷新和加载更多
/// 3. 定义了一个items列表，用于存放列表数据
/// 4. 定义了一个_page变量，用于存放当前页码
/// 5. 定义了一个inLoading变量，用于判断是否正在加载数据
/// 6. 在initState方法中，调用了refresh方法，用于初始化列表数据
/// 7. 定义了一个buildRefreshList方法，用于构建列表，该方法返回一个SmartRefresher组件，该组件包含了列表的刷新和加载更多功能
/// 8. 定义了一个itemBuilder方法，用于构建列表的item，该方法返回一个buildListItem方法，该方法需要在子类中实现
/// 9. 定义了一个refresh方法，用于刷新列表数据，该方法调用了loadData方法，该方法需要在子类中实现
/// 10. 定义了一个loadMore方法，用于加载更多数据，该方法调用了loadData方法，该方法需要在子类中实现
/// 11. 定义了一个onDataChanged方法，用于刷新或加载更多数据变更
/// 12. 定义了一个buildEmptyView方法，用于构建空数据布局
abstract class BaseRefreshListState<T, S extends BaseRefreshList>
    extends RouteAwareState<S> with AutomaticKeepAliveClientMixin {
  late final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<T> items = [];

  final int initPage = 1;
  late int _page = initPage;
  bool inLoading = true;

  List<Widget> _headerBuilders = [];
  List<Widget> _footerBuilders = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      refresh(byUser: false);
    });
    widget.controller?._bindState(this);
  }

  Widget buildRefreshList({
    required Widget child,
    Axis scrollDirection = Axis.vertical,
    EmptyConfig? emptyConfig,
    ScrollPhysics? physics = const BouncingScrollPhysics(),
    bool enableRefresh = true,
    bool enableLoadMore = true,
    List<Widget> headerBuilders = const [],
    List<Widget> footerBuilders = const [],
  }) {
    this._headerBuilders = headerBuilders;
    this._footerBuilders = footerBuilders;
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: enableRefresh,
        enablePullUp: enableLoadMore && items.isNotEmpty,
        scrollDirection: scrollDirection,
        onRefresh: refresh,
        physics: physics,
        onLoading: () => loadMore(_page + 1),
        footer: const ListFooter(),
        child: itemCount < 1 ? buildEmptyView(emptyConfig) : child,
      ),
    );
  }

  int get itemCount {
    return items.length + _headerBuilders.length + _footerBuilders.length;
  }

  /// do not override
  Widget itemBuilder(BuildContext context, int index) {
    int headerLength = _headerBuilders.length;
    int footerIndex = headerLength + items.length;
    if (index < headerLength) {
      return _headerBuilders[index];
    } else if (index >= footerIndex) {
      index = index - headerLength - items.length;
      return _footerBuilders[index];
    } else {
      index = index - headerLength;
      return buildListItem(context, getItem(index), index);
    }
  }

  Widget buildListItem(BuildContext context, T item, int index);

  T getItem(int index) {
    return items[index];
  }

  refresh({bool byUser = true}) async {
    try {
      inLoading = true;
      items = await loadData(initPage);
      _page = initPage;
      _refreshController.refreshCompleted(resetFooterState: true);
      onDataChanged(items);
    } catch (e) {
      _refreshController.refreshFailed();
      // e.toString().print();
    } finally {
      inLoading = false;
      if (context.mounted) {
        setState(() {});
      }
    }
  }

  Future<List<T>> loadData(int page);

  loadMore(int page) async {
    try {
      inLoading = true;
      var list = await loadData(page);
      if (list.isEmpty) {
        _refreshController.loadNoData();
      } else {
        _page++;
        items.addAll(list);
        _refreshController.loadComplete();
      }
      onDataChanged(items);
    } catch (e) {
      _refreshController.loadFailed();
      // e.toString().print();
    } finally {
      inLoading = false;
      if (context.mounted) {
        setState(() {});
      }
    }
  }

  /// 刷新或加载更多数据变更
  void onDataChanged(List<T> items) {}

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  /// 空数据布局
  Widget buildEmptyView(EmptyConfig? config) {
    return Container(
      color: config?.backgroundColor,
      padding: EdgeInsets.only(bottom: 40),
      child: Visibility(
        visible: !inLoading,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            config?.imageView ?? Image.asset(config?.image ?? "", width: 150),
            SizedBox(height: config?.centerTop ?? 20),
            config?.textView ??
                Text(config?.text ?? "",
                    style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: config?.centerBottom ?? 20),
            config?.body ?? const SizedBox(),
            SizedBox(height: config?.body != null ? 14 : 0),
            config?.button ??
                Visibility(
                  visible: config?.btnVisible ?? false,
                  child: Container(
                    constraints: BoxConstraints(minWidth: 167),
                    child: TextButton(
                      onPressed: config?.onPress,
                      child: Text(
                        "${config?.btnText}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            // SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class BaseRefreshController {
  late BaseRefreshListState _state;

  _bindState(BaseRefreshListState state) {
    _state = state;
  }

  void refresh() {
    _state.refresh();
  }
}
