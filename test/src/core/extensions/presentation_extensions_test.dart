import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/extensions/presentation_extensions.dart';

void main() {
  group('ValueListenableExtensions', () {
    testWidgets('observer rebuilds on value change',
        (WidgetTester tester) async {
      final notifier = ValueNotifier<int>(0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: notifier.observer(
              builder: (_, value, __) {
                return Text('Value: $value');
              },
            ),
          ),
        ),
      );

      expect(find.text('Value: 0'), findsOneWidget);

      notifier.setValue(1);
      await tester.pumpAndSettle();

      expect(find.text('Value: 1'), findsOneWidget);
    });
  });

  group('ValueNotifierExtension', () {
    test('setValue updates the value', () {
      final notifier = ValueNotifier<int>(0);

      expect(notifier.value, 0);

      notifier.setValue(5);

      expect(notifier.value, 5);
    });
  });
}
