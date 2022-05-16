import 'package:dio_view/dio_view.dart';
import 'package:flutter/material.dart';
import 'package:dio_view_ume_adapter/src/models/store_model.dart';
import 'package:dio_view_ume_adapter/src/widgets/simple_navigator.dart';

class RequestTile extends StatelessWidget {
  final StoreModel model;
  const RequestTile({Key? key, required this.model}) : super(key: key);

  TextSpan get _method {
    final text = model.requestOptions.method;
    var color = Colors.grey;
    switch (text.toLowerCase()) {
      case 'get':
        color = Colors.green;
        break;
      case 'post':
        color = Colors.blue;
        break;
      case 'put':
        color = Colors.orange;
        break;
      case 'delete':
        color = Colors.red;
        break;
      case 'patch':
        color = Colors.purple;
        break;
      case 'head':
        color = Colors.indigo;
        break;
      case 'options':
        color = Colors.teal;
        break;
      case 'connect':
        color = Colors.lime;
        break;
      case 'trace':
        color = Colors.pink;
        break;
    }

    return TextSpan(
      text: '$text ',
      style: TextStyle(
        color: color,
      ),
    );
  }

  TextSpan _getStatusSpan(int code) {
    final text = code.toString();
    Color? color;
    switch (code) {
      case 200:
        color = Colors.green;
        break;
    }
    return TextSpan(
      text: '$text ',
      style: TextStyle(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? trailing;
    Color? tileColor;
    final subtitleSpanList = <TextSpan>[];
    final titleSpanList = <TextSpan>[
      _method,
      TextSpan(text: model.requestOptions.path),
    ];

    switch (model.status) {
      case StoreStatus.pending:
        trailing = const Text('Pending');
        break;
      case StoreStatus.success:
        trailing = Text('${model.cost?.inMilliseconds}ms');
        break;
    }

    if (model.status == StoreStatus.pending) {
      tileColor = Colors.blue.withOpacity(0.2);
    }
    if (model.error != null) {
      tileColor = Colors.red.withOpacity(0.4);
      if (model.status == StoreStatus.success) {
        if (model.error != null && model.error!.response != null) {
          subtitleSpanList.add(TextSpan(
            text: '${model.error!.response!.statusCode}',
          ));
        }
      }

      subtitleSpanList.add(TextSpan(text: model.error!.message));
    }

    if (model.response?.statusCode != null) {
      subtitleSpanList.add(_getStatusSpan(model.response!.statusCode!));
    }

    return ListTile(
      tileColor: tileColor,
      dense: true,
      title: RichText(
        text: TextSpan(
          children: titleSpanList,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        maxLines: 1,
      ),
      subtitle: RichText(
        text: TextSpan(
          children: subtitleSpanList,
          style: Theme.of(context).textTheme.caption,
        ),
        maxLines: 1,
      ),
      trailing: trailing,
      onTap: () {
        if (model.response != null) {
          SimpleNavigator.push(ResponseView(
            response: model.response!,
            onBack: () {
              SimpleNavigator.back();
            },
          ));
        } else if (model.error != null) {
          SimpleNavigator.push(ErrorView(
            error: model.error!,
            onBack: () {
              SimpleNavigator.back();
            },
          ));
        }
      },
    );
  }
}
