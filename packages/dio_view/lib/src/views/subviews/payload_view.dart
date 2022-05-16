import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../widgets/map_data_tile.dart';
import '../../widgets/empty_widget.dart';

typedef PayloadMap = Map<String, dynamic>?;

class PayloadView extends StatelessWidget {
  final PayloadMap query;
  final dynamic body;
  const PayloadView({
    Key? key,
    this.query,
    this.body,
  }) : super(key: key);

  PayloadView.fromRequestOptions(RequestOptions options, {Key? key})
      : query = options.uri.queryParameters,
        body = options.data,
        super(key: key);

  bool get isFormData => body is FormData;
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (query != null && query!.isNotEmpty) {
      children.add(MapDataTile(
        map: query!,
        title: const Text('Query Parameters'),
      ));
    }

    if (body is FormData) {
      final bodyForm = body as FormData;
      if (bodyForm.length != 0) {
        final resultForm = <String, dynamic>{};
        for (var item in bodyForm.fields) {
          resultForm.putIfAbsent(item.key, () => item.value);
        }
        for (var file in bodyForm.files) {
          resultForm.putIfAbsent(file.key, () => file.value.filename ?? 'FILE');
        }
        children.add(MapDataTile(
          map: resultForm,
          title: const Text('FormData'),
        ));
      }
    }

    if (body is Map) {
      children.add(MapDataTile(
        map: body!,
        title: const Text('Request Payload'),
      ));
    }

    if (children.isEmpty) return const EmptyWidget();

    return ListView(children: children);
  }
}
