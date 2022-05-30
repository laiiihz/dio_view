import 'package:dio/dio.dart';
import 'package:dio_view_ume_adapter/dio_view_ume_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockContext extends Mock implements BuildContext {}

final Dio _dio = Dio();

void main() {
  group('Dio View UME Adapter', () {
    test('Pluggable', () {
      final DioViewUMEAdapter pluggable = DioViewUMEAdapter(dio: _dio);
      final Widget widget = pluggable.buildWidget(MockContext());
      final String name = pluggable.name;
      final VoidCallback onTrigger = pluggable.onTrigger..call();
      final ImageProvider imageProvider = pluggable.iconImageProvider;

      expect(widget, isA<Widget>());
      expect(name, isNotEmpty);
      expect(onTrigger, isA<Function>());
      expect(imageProvider, isNotNull);
    });

    testWidgets('DioViewUMEAdapter pump widget', (tester) async {
      final DioViewUMEAdapter inspector = DioViewUMEAdapter(dio: _dio);
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: inspector)),
      );
      await tester.pumpAndSettle();
      expect(inspector, isNotNull);
    });
  });
}
