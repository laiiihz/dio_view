import 'package:flutter/material.dart';
import 'package:stack_trace/stack_trace.dart';

class StackView extends StatelessWidget {
  final StackTrace? stack;
  const StackView({Key? key, required this.stack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (stack == null) return const SizedBox.shrink();
    final items = Trace.from(stack!).frames;
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = items[index];
        bool isSDK = item.isCore || item.package == 'flutter';

        return ListTile(
          leading: Text('#$index'),
          trailing:
              item.package == null ? null : Chip(label: Text(item.package!)),
          title: Text(item.member ?? ''),
          subtitle: Text(item.location),
          tileColor: isSDK ? Colors.grey.withOpacity(0.2) : null,
        );
      },
      itemCount: items.length,
    );
  }
}
