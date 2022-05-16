import 'package:flutter/material.dart';
import 'key_value_item.dart';
import 'package:json_view/json_view.dart';

class MapDataTile extends StatefulWidget {
  final Widget title;
  final Map<String, dynamic> map;
  const MapDataTile({Key? key, required this.map, required this.title})
      : super(key: key);

  @override
  State<MapDataTile> createState() => _MapDataTileState();
}

class _MapDataTileState extends State<MapDataTile> {
  bool _showMap = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: widget.title,
      initiallyExpanded: true,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      leading: IconButton(
        onPressed: () {
          setState(() {
            _showMap = !_showMap;
          });
        },
        icon: _showMap
            ? const Icon(Icons.all_inbox_rounded)
            : const Icon(Icons.code),
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      children: _showMap
          ? [
              JsonViewBody(json: widget.map),
            ]
          : widget.map.entries.map((e) {
              return KeyValueItem(itemKey: e.key, value: e.value);
            }).toList(),
    );
  }
}
