import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ume/core/pluggable.dart';
import 'package:dio_view_ume_adapter/src/assets/_icon.dart' as icon;
import 'package:dio_view_ume_adapter/src/ume_kit_dio_interceptor.dart';
import 'package:dio_view_ume_adapter/src/views/request_wrapper_view.dart';
import 'package:dio_view_ume_adapter/src/widgets/simple_navigator.dart';

class DioInspector2 extends StatefulWidget implements Pluggable {
  /// a dio client
  final Dio? dio;

  /// pass dio or add interceptor to dio client
  DioInspector2({Key? key, this.dio}) : super(key: key) {
    if (dio != null) {
      dio!.interceptors.add(UMEKitDioInterceptor());
    }
  }

  @override
  State<DioInspector2> createState() => _DioInspector2State();

  @override
  Widget buildWidget(BuildContext? context) => this;

  @override
  String get displayName => 'DioInspector2';

  @override
  ImageProvider<Object> get iconImageProvider => MemoryImage(icon.iconBytes);

  @override
  String get name => 'Dio Inspector 2';

  @override
  void onTrigger() {}
}

class _DioInspector2State extends State<DioInspector2> {
  @override
  Widget build(BuildContext context) {
    return SimpleNavigator(const RequestWrapperView());
  }
}
