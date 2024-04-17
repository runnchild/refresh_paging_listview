import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:refresh_paging_listview/refresh_paging_listview.dart';

abstract class BaseRefreshList extends StatefulWidget {
  final BaseRefreshController? controller;

  const BaseRefreshList({Key? key, this.controller}) : super(key: key);
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
  late RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<T> items = [];

  late final int initPage;
  late int _page = initPage;
  bool inLoading = true;
  EmptyConfig? mEmptyConfig;

  List<Widget> _headers = [];
  List<Widget> _footers = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initPage = RefreshConfiguration.of(context)?.initPage ?? 1;
      refresh(byUser: false);
    });
    widget.controller?._bindState(this);
  }

  /// See [SmartRefresher]
  Widget buildRefreshList({
    Key? key,
    required Widget child,
    RefreshController? controller,
    Widget? refreshHeader,
    Widget? refreshFooter,
    bool enableRefresh = true,
    bool enableLoadMore = true,
    bool enableTwoLevel = false,
    OnTwoLevel? onTwoLevel,
    DragStartBehavior? dragStartBehavior,
    bool? primary,
    double? cacheExtent,
    int? semanticChildCount,
    bool? reverse,
    ScrollPhysics? physics = const BouncingScrollPhysics(),
    Axis scrollDirection = Axis.vertical,
    ScrollController? scrollController,
    List<Widget> headers = const [],
    List<Widget> footers = const [],
    EmptyConfig? emptyConfig,
  }) {
    this._headers = headers;
    this._footers = footers;
    if (controller != null) {
      _refreshController = controller;
    }
    mEmptyConfig = emptyConfig ?? RefreshConfiguration.of(context)?.emptyConfig;
    mEmptyConfig?.onPress = () {
      refresh();
    };

    return SmartRefresher(
      key: key,
      controller: _refreshController,
      header: refreshHeader,
      footer: refreshFooter,
      enablePullDown: enableRefresh,
      enablePullUp: enableLoadMore && items.isNotEmpty,
      enableTwoLevel: enableTwoLevel,
      onTwoLevel: onTwoLevel,
      dragStartBehavior: dragStartBehavior,
      primary: primary,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      reverse: reverse,
      physics: physics,
      scrollDirection: scrollDirection,
      scrollController: scrollController,
      onRefresh: refresh,
      onLoading: () => loadMore(_page + 1),
      child: itemCount < 1 && !inLoading ? buildEmptyView(mEmptyConfig) : child,
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      (context as Element).markNeedsBuild();
    });
  }

  /// 包含header和footer的列表元素数量
  /// 如果[showEmptyViewWhenListEmpty]=true,即列表数据为空即使有header或footer也展示EmptyView，
  /// 当列表为空时实际的itemCount为header+footer+1
  int get itemCount {
    var headAndFootLength = _headers.length + _footers.length;

    if (mEmptyConfig?.showEmptyViewWhenListEmpty == true &&
        items.isEmpty &&
        headAndFootLength > 0) {
      return headAndFootLength + 1;
    }
    return headAndFootLength + items.length;
  }

  /// do not override
  Widget itemBuilder(BuildContext context, int index) {
    if (kDebugMode && index >= itemCount) {
      return const SizedBox();
    }
    int headerLength = _headers.length;
    int footerIndex = itemCount - _footers.length;
    if (index < headerLength) {
      return _headers[index];
    } else if (index >= footerIndex) {
      index = index - footerIndex;
      return _footers[index];
    } else {
      if (items.isEmpty) {
        return buildEmptyView(mEmptyConfig);
      } else {
        index = index - headerLength;
        return buildListItem(context, getItem(index), index);
      }
    }
  }

  /// 返回列表Item Widget
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
    } finally {
      inLoading = false;
      if (context.mounted) {
        setState(() {});
      }
    }
  }

  /// 分页请求数据
  /// [page] 分页页码
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
    } finally {
      inLoading = false;
      if (context.mounted) {
        setState(() {});
      }
    }
  }

  /// 刷新或加载更多后数据变更
  void onDataChanged(List<T> items) {}

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  /// 空数据布局
  Widget buildEmptyView(EmptyConfig? config) {
    return RefreshConfiguration.of(context)?.emptyBuilder?.call(config) ??
        const SizedBox();
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
