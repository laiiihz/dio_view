import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dio_view_ume_adapter/src/extensions/dio_extension.dart';
import 'package:dio_view_ume_adapter/src/models/store_model.dart';

final umeKitDioStore = UMEKitDioStore();

class UMEKitDioStore extends ChangeNotifier {
  final _store = <StoreModel>[];

  int get length => _store.length;
  List<StoreModel> get store => _store;

  int start(RequestOptions request) {
    final item = StoreModel.start(requestOptions: request);
    _store.add(item);
    notifyListeners();
    return item.id;
  }

  end({Response? response, DioError? error}) {
    late RequestOptions requestOptions;
    if (response != null) requestOptions = response.requestOptions;
    if (error != null) requestOptions = error.requestOptions;
    final currentId = requestOptions.dioId;
    final index = _store.indexWhere((element) => element.id == currentId);
    if (index != -1) {
      _store[index] = _store[index].update(
        responseData: response,
        errorData: error,
      );
    } else {
      _store.add(StoreModel.end(responseData: response, errorData: error));
    }

    notifyListeners();
  }

  clear() {
    _store.clear();
    notifyListeners();
  }
}
