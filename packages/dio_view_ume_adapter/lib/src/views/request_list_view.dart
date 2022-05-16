import 'package:flutter/material.dart';
import 'package:dio_view_ume_adapter/src/ume_kit_dio_store.dart';

import '../widgets/request_tile.dart';

class RequestListView extends StatefulWidget {
  const RequestListView({Key? key}) : super(key: key);

  @override
  State<RequestListView> createState() => _RequestListViewState();
}

class _RequestListViewState extends State<RequestListView> {
  void update() => setState(() {});
  @override
  void initState() {
    super.initState();
    umeKitDioStore.addListener(update);
  }

  @override
  void dispose() {
    umeKitDioStore.removeListener(update);
    super.dispose();
  }

  int get _length => umeKitDioStore.length;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final item = umeKitDioStore.store[index];
        return RequestTile(model: item);
      },
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemCount: _length,
    );
  }
}
