import 'package:flutter/material.dart';
import 'package:refresh_paging_listview/refresh_paging_listview.dart';

class EmptyView extends StatefulWidget {
  final EmptyConfig? config;
  const EmptyView({super.key, this.config});

  @override
  State<EmptyView> createState() => _EmptyViewState();
}

class _EmptyViewState extends State<EmptyView> {
  late EmptyConfig? config = widget.config;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: config?.backgroundColor,
      constraints: const BoxConstraints(minHeight: 500),
      padding: const EdgeInsets.only(bottom: 40),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          config?.imageView ?? Image.asset(config?.image ?? "", width: 150),
          const SizedBox(height: 20),
          config?.textView ??
              Text(config?.text ?? "",
                  style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height:  20),
          config?.button ??
              Visibility(
                visible: config?.btnVisible ?? config?.btnText != null,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 167),
                  child: TextButton(
                    onPressed: config?.onPress,
                    child: Text(
                      "${config?.btnText}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          // SizedBox(height: 80),
        ],
      ),
    );
  }
}
