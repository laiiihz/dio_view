import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '🌻\n No Data to Display',
        textAlign: TextAlign.center,
      ),
    );
  }
}
