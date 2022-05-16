import 'package:dio/dio.dart';
import 'package:dio_view_ume_adapter/src/extensions/dio_extension.dart';
import 'package:dio_view_ume_adapter/src/ume_kit_dio_store.dart';

class UMEKitDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final id = umeKitDioStore.start(options);
    options.startTick(id);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    umeKitDioStore.end(response: response);
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    umeKitDioStore.end(error: err);
    handler.next(err);
  }
}
