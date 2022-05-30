import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_ume/flutter_ume.dart';
import 'package:dio_view_ume_adapter/dio_view_ume_adapter.dart';

final _dio = Dio();
void main() {
  if (kDebugMode) {
    PluginManager.instance.register(DioViewUMEAdapter(dio: _dio));
    runApp(const UMEWidget(child: MyApp()));
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio View UME Adapter',
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Dio View UME Adapter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = 'https://reqres.in/api/users';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                ),
              ),
              IconButton(
                  onPressed: () {
                    _dio.get(_controller.text);
                  },
                  icon: const Icon(Icons.send)),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              _dio.get('https://reqres.in/api/users?delay=6');
            },
            child: const Text('delay 6'),
          ),
          ElevatedButton(
            onPressed: () {
              _dio.get('https://alwkemflawex.in');
            },
            child: const Text('error'),
          ),
          ElevatedButton(
            onPressed: () {
              _dio.post(
                'https://reqres.in/api/users',
                data: {
                  'name': 'dio kit 2',
                  'job': 'test job',
                },
              );
            },
            child: const Text('post'),
          ),
          ElevatedButton(
            onPressed: () {
              _dio.post(
                'https://reqres.in/api/users',
                data: FormData.fromMap({
                  'name': 'dio kit 2',
                  'job': 'test job',
                  'file': MultipartFile.fromString('TESTFILE'),
                }),
              );
            },
            child: const Text('FORMDATA'),
          ),
        ],
      ),
    );
  }
}
