import 'package:example/task_page.dart';
import 'package:flutter/material.dart';
import 'package:refresh_paging_listview/refresh_paging_listview.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: ()  => WaterDropHeader(),
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
