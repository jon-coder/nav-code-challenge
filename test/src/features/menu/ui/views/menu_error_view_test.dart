import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/features/menu/ui/views/menu_error_view.dart';

void main() {
  testWidgets('MenuErrorView displays error message and button',
      (WidgetTester tester) async {
    // Arrange
    const String errorMessage = 'An error occurred';
    bool buttonPressed = false;

    void refresh() {
      buttonPressed = true;
    }

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MenuErrorView(
            errorMessage: errorMessage,
            refresh: refresh,
          ),
        ),
      ),
    );

    expect(find.text(errorMessage), findsOneWidget);

    expect(find.byIcon(Icons.error_outline_outlined), findsOneWidget);

    expect(find.text('TRY AGAIN'), findsOneWidget);

    // Act
    await tester.tap(find.text('TRY AGAIN'));
    await tester.pump();

    // Assert: Checks if the refresh function has been called
    expect(buttonPressed, isTrue);
  });
}
