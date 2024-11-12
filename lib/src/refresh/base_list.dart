import 'package:flutter/material.dart';


abstract class BaseListState<T extends StatefulWidget> extends State<T> {

  List<Widget> _headers = [];
  List<Widget> _footers = [];

  /// do not override
  Widget itemBuilder(BuildContext context, int index) {
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
}
