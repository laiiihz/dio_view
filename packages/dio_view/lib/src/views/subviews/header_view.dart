import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../widgets/map_data_tile.dart';

typedef HeaderMap = Map<String, dynamic>?;

class HeaderView extends StatelessWidget {
  final HeaderMap generalMap;
  final HeaderMap requestHeader;
  final HeaderMap responseHeader;

  const HeaderView({
    Key? key,
    required this.requestHeader,
    required this.responseHeader,
    required this.generalMap,
  }) : super(key: key);

  HeaderView.fromResponse(Response response, {Key? key})
      : requestHeader = response.requestOptions.headers,
        responseHeader = response.headers.map,
        generalMap = _GeneralMap.fromResponse(response).toMap(),
        super(key: key);

  HeaderView.fromError(DioError error, {Key? key})
      : requestHeader = error.requestOptions.headers,
        responseHeader = error.response?.headers.map,
        generalMap = _GeneralMap.fromError(error).toMap(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (generalMap != null)
          MapDataTile(
            map: generalMap!,
            title: const Text('General'),
          ),
        if (requestHeader != null)
          MapDataTile(
            title: const Text('Request Headers'),
            map: requestHeader!,
          ),
        if (responseHeader != null)
          MapDataTile(
            title: const Text('Response Headers'),
            map: responseHeader!,
          ),
      ],
    );
  }
}

class _GeneralMap {
  final Uri fullUri;
  final String method;
  final int? statusCode;
  final String? message;
  _GeneralMap({
    required this.fullUri,
    required this.method,
    required this.statusCode,
    this.message,
  });
  _GeneralMap.fromResponse(Response response)
      : fullUri = response.requestOptions.uri,
        method = response.requestOptions.method,
        statusCode = response.statusCode,
        message = null;

  _GeneralMap.fromError(DioError error)
      : fullUri = error.requestOptions.uri,
        method = error.requestOptions.method,
        statusCode = error.response?.statusCode,
        message = error.message;

  Map<String, dynamic> toMap() {
    return {
      'Request Uri': fullUri.toString(),
      'Request Method': method,
      if (statusCode != null) 'Status Code': statusCode,
      if (message != null) 'Message': message,
    };
  }
}
