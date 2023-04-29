import 'package:flutter/material.dart';

class EmptyFooter extends StatelessWidget {
  final String? content;
  final double? fontSize;

  const EmptyFooter({Key? key, this.content, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = const Color(0xFF999999);
    return SizedBox(
      height: 27,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 34,
            child: Divider(height: 1, color: color),
          ),
          SizedBox(width: 18),
          Text(
            content ?? "",
            style: TextStyle(color: color, fontSize: fontSize ?? 12),
          ),
          SizedBox(width: 18),
          SizedBox(
            width: 34,
            child: Divider(height: 1, color: color),
          ),
        ],
      ),
    );
  }
}
