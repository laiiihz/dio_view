import 'package:flutter/material.dart';

class KeyValueItem extends StatelessWidget {
  final String itemKey;
  final dynamic value;
  const KeyValueItem({
    Key? key,
    required this.itemKey,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$itemKey: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: value.toString()),
        ],
      ),
      style: Theme.of(context).textTheme.caption,
    );
  }
}
