import 'package:flutter/material.dart';

class ListHeaderItem extends StatelessWidget {
  const ListHeaderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      alignment: Alignment.center,
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Text("List Header"),
      ),
    );
  }
}
