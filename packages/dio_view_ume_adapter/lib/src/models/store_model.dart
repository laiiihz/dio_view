import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum StoreStatus {
  pending,
  success,
}

@immutable
class StoreModel {
  static int gid = 0;
  final int id;
  final DateTime? startDate;
  final DateTime? endDate;
  final RequestOptions requestOptions;

  final Response? response;
  final DioError? error;

  StoreStatus get status => response == null && error == null
      ? StoreStatus.pending
      : StoreStatus.success;

  Duration? get cost {
    if (endDate != null && startDate != null) {
      return endDate!.difference(startDate!);
    }
    return null;
  }

  const StoreModel({
    required this.id,
    this.startDate,
    this.endDate,
    required this.requestOptions,
    this.response,
    this.error,
  });

  StoreModel update({Response? responseData, DioError? errorData}) {
    return StoreModel(
      id: id,
      startDate: startDate,
      endDate: DateTime.now(),
      requestOptions: requestOptions,
      response: responseData ?? response,
      error: errorData ?? error,
    );
  }

  StoreModel.start({
    this.endDate,
    required this.requestOptions,
    this.response,
    this.error,
  })  : startDate = DateTime.now(),
        id = gid++;

  factory StoreModel.end({Response? responseData, DioError? errorData}) {
    assert(responseData != null || errorData != null);
    late RequestOptions request;
    if (responseData != null) request = responseData.requestOptions;
    if (errorData != null) request = errorData.requestOptions;
    return StoreModel(
      id: gid++,
      requestOptions: request,
      response: responseData,
      error: errorData,
      endDate: DateTime.now(),
    );
  }
}
