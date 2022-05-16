import 'package:dio/dio.dart';

import '../consts/constants.dart';

extension RequestOptionsExt on RequestOptions {
  RequestOptions startTick(int id) =>
      this..headers.putIfAbsent(kIdTag, () => id.toString());

  int? get dioId => int.tryParse(headers[kIdTag] ?? '0');
}
