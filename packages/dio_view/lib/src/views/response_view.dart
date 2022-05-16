import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'subviews/data_view.dart';
import 'subviews/header_view.dart';
import 'subviews/payload_view.dart';

class ResponseView extends StatefulWidget {
  final Response response;
  final VoidCallback? onBack;
  const ResponseView({Key? key, required this.response, this.onBack})
      : super(key: key);

  @override
  State<ResponseView> createState() => _ResponseViewState();
}

class _ResponseViewState extends State<ResponseView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
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
        leading: BackButton(onPressed: widget.onBack),
        title: Column(
          children: [
            Text(widget.response.realUri.path),
            Text(
              widget.response.realUri.host,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(text: 'Header'),
            Tab(text: 'Payload'),
            Tab(text: 'Data'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          HeaderView.fromResponse(widget.response),
          PayloadView.fromRequestOptions(widget.response.requestOptions),
          DataView(data: widget.response.data),
        ],
      ),
    );
  }
}
