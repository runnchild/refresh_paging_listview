# refresh_paging_listview
<a href="https://pub.dev/packages/refresh_paging_listview">
  <img src="https://img.shields.io/pub/v/refresh_paging_listview.svg"/>
</a>
<a href="https://flutter.dev/">
  <img src="https://img.shields.io/badge/flutter-%3E%3D%203.0.0-green.svg"/>
</a>
<a href="https://opensource.org/licenses/MIT">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg"/>
</a>

## 介绍
刷新和加载更多部分看([flutter_pulltorefresh])(https://github.com/xxzj990-game/flutter_pulltorefresh/blob/master/README.md)

```yaml

   dependencies:

     refresh_paging_listview: ^1.1.0


```
import package

```dart

   import 'package:flutter_list/refresh/base_refresh_list.dart';

```
分页部分 simple example

```dart
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
         body: buildRefreshList(
           enableLoadMore: false,
           emptyConfig: EmptyConfig(...),
           headers: [
             LoginHeader(),
           ],
           footers: [
             FooterWidget(),
           ],
           child: ListView.builder(
               itemBuilder: itemBuilder,
               itemCount: itemCount,
           ),
         ),
       );
     }
     
     @override
     Widget buildListItem(BuildContext context, TaskEntity item, int index) {
       return ListTile(...);
     }
     
     @override
     Future<List<TaskEntity>> loadData(int page) async {
       return [data];
     }
   }
```
