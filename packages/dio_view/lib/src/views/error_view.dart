import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'subviews/header_view.dart';
import 'subviews/payload_view.dart';
import 'subviews/stack_view.dart';

import 'subviews/data_view.dart';

class ErrorView extends StatefulWidget {
  final DioError error;
  final VoidCallback? onBack;
  const ErrorView({Key? key, required this.error, this.onBack})
      : super(key: key);

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
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
            Text(widget.error.requestOptions.uri.path),
            Text(
              widget.error.requestOptions.uri.host,
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
            Tab(text: 'Stack Trace'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          HeaderView.fromError(widget.error),
          PayloadView.fromRequestOptions(widget.error.requestOptions),
          DataView(data: widget.error.response?.data),
          StackView(stack: widget.error.stackTrace),
        ],
      ),
    );
  }
}
