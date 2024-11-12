import 'package:example/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:refresh_paging_listview/refresh_paging_listview.dart';

import 'list_footer_item.dart';
import 'list_header_item.dart';
import 'task_entity.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const WaterDropHeader(),
      //分页接口初始页码
      initPage: 1,
      //空数据时的空页面
      emptyBuilder: (config) => EmptyView(config: config),
      emptyConfig: EmptyConfig(
        text: "暂无数据，请稍后再试！",
        image: "images/ic_empty.png",
      ),
      child: MaterialApp(
        title: "RefreshPagingListView",
        theme: ThemeData(),
        home: const TaskPage(),
        localizationsDelegates: const [
          RefreshLocalizations.delegate,
        ],
      ),
    );
  }
}

class TaskPage extends BaseRefreshList {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends BaseRefreshListState<TaskEntity, TaskPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text("RefreshPagingListView")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            items.clear();
          });
        },
        child: const Text("CLEAR"),
      ),
      body: buildRefreshList(
        // enableLoadMore: false,
        emptyConfig: RefreshConfiguration.of(context)?.emptyConfig?.copyWith(
              btnText: "重试",
            ),
        headers: [
          const ListHeaderItem(),
          const ListHeaderItem(),
        ],
        footers: [
          const ListFooterItem(),
          const ListFooterItem(),
        ],
        child: ListView.separated(
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          separatorBuilder: (c, i) => const Divider(height: 1),
        ),
      ),
    );
  }

  @override
  Widget buildListItem(BuildContext context, TaskEntity item, int index) {
    return ListTile(
      title: Text("item: $index"),
    );
  }

  @override
  Future<List<TaskEntity>> loadData(int page) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return [
        TaskEntity(),
        TaskEntity(),
        TaskEntity(),
        TaskEntity(),
        TaskEntity(),
      ];
    });
  }
}
