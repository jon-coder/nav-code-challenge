import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/ui/app_colors.dart';
import 'package:navalia_code_challenge/src/features/menu/ui/views/menu_loading_view.dart';

void main() {
  testWidgets('MenuLoadingView displays CircularProgressIndicator',
      (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MenuLoadingView(),
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    final CircularProgressIndicator circularProgressIndicator =
        tester.widget<CircularProgressIndicator>(
            find.byType(CircularProgressIndicator));

    expect(circularProgressIndicator.color, isNotNull);
    expect(circularProgressIndicator.color, AppColors.primary);
  });
}
