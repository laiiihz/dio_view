import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:dio_view_ume_adapter/src/ume_kit_dio_store.dart';
import 'package:dio_view_ume_adapter/src/views/request_list_view.dart';

class RequestWrapperView extends StatefulWidget {
  const RequestWrapperView({Key? key}) : super(key: key);

  @override
  State<RequestWrapperView> createState() => _RequestWrapperViewState();
}

class _RequestWrapperViewState extends State<RequestWrapperView> {
  bool _fullScreen = false;

  double get _sWidth => MediaQuery.of(context).size.width;
  double get _sHeight => MediaQuery.of(context).size.height;
  double get _maxHeight => math.max<double>(240, _sHeight / 2.5);
  double get _minHeight => math.min<double>(240, _sHeight);
  double get _maxWidth => math.min(600, _sWidth);

  bool get _verySmallScreen => _minHeight == MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    Widget result = Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            const Text('Dio Inspector 2'),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.clear_all_rounded),
              onPressed: () {
                umeKitDioStore.clear();
              },
            ),
            if (!_verySmallScreen)
              IconButton(
                onPressed: () {
                  setState(() {
                    _fullScreen = !_fullScreen;
                  });
                },
                icon: _fullScreen
                    ? const Icon(Icons.fullscreen_exit_rounded)
                    : const Icon(Icons.fullscreen_rounded),
              ),
          ],
        ),
        const Expanded(child: RequestListView()),
      ],
    );

    if (_verySmallScreen || _fullScreen) {
      result = Material(child: result);
    } else {
      result = Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: _minHeight,
            maxHeight: _maxHeight,
            maxWidth: _maxWidth,
          ),
          child: Material(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: result,
          ),
        ),
      );
      // add shadow
      result = Material(color: Colors.black54, child: result);
    }

    result = SafeArea(child: result);

    return result;
  }
}
