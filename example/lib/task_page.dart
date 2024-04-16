import 'package:flutter/material.dart';
import 'package:refresh_paging_listview/refresh_paging_listview.dart';

import 'list_footer_item.dart';
import 'list_header_item.dart';
import 'task_entity.dart';

class TaskPage extends BaseRefreshList {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends BaseRefreshListState<TaskEntity, TaskPage> {
  var headers = <Widget>[];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: GestureDetector(onTap: () {
      }, child: const Text("RefreshPagingListView"))),
      body: buildRefreshList(
        // enableLoadMore: false,
        emptyConfig: EmptyConfig(
          text: "暂无数据",
          imageView: const Icon(Icons.ac_unit_outlined, size: 90),
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
    return GestureDetector(
      onTap: () {
      },
      child: ListTile(
        title: Text("item: $index"),
      ),
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
