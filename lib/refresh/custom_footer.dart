import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'empty_footer.dart';

class ListFooter extends StatelessWidget {
  const ListFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = RefreshLocalizations.of(context)?.currentLocalization ?? EnRefreshString();
    return CustomFooter(
      loadStyle: LoadStyle.ShowWhenLoading,
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text(localization.idleLoadingText ?? "上拉加载");
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text(localization.loadFailedText ?? "加载失败！点击重试！");
        } else if (mode == LoadStatus.canLoading) {
          body = Text(localization.canLoadingText ?? "松手,加载更多!");
        } else {
          body = EmptyFooter(content: localization.noMoreText ?? "已经到底啦");
        }
        return SizedBox(
          height: 55,
          child: Center(child: body),
        );
      },
    );
  }
}
