import 'package:flutter/material.dart';

class ListFooterItem extends StatelessWidget {
  const ListFooterItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      alignment: Alignment.center,
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Text("List Footer"),
      ),
    );
  }
}
