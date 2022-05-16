import 'package:flutter/material.dart';

final _kNavigatorKey = GlobalKey<SimpleNavigatorState>();

class SimpleNavigator extends StatefulWidget {
  final Widget root;
  SimpleNavigator(this.root) : super(key: _kNavigatorKey);

  static push(Widget child) => _kNavigatorKey.currentState?.push(child);

  static back() => _kNavigatorKey.currentState?.back();

  @override
  State<SimpleNavigator> createState() => SimpleNavigatorState();
}

class SimpleNavigatorState extends State<SimpleNavigator> {
  final _pages = <Widget>[];

  push(Widget child) {
    _pages.add(child);
    setState(() {});
  }

  back() {
    while (_pages.length > 1) {
      _pages.removeLast();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _pages.add(widget.root);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: _pages);
  }
}
