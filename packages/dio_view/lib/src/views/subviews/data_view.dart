import 'package:flutter/material.dart';
import '../../widgets/empty_widget.dart';
import 'package:json_view/json_view.dart';

class DataView extends StatelessWidget {
  final dynamic data;
  const DataView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null) return const EmptyWidget();
    if (data is Map || data is List) {
      return JsonView(
        json: data,
        padding: const EdgeInsets.all(8),
      );
    }
    return SingleChildScrollView(
      child: SelectableText(data.toString()),
    );
  }
}
