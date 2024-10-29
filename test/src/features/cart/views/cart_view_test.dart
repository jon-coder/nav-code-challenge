import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/core/service_locator/domain/interfaces/i_service_locator.dart';
import 'package:navalia_code_challenge/src/features/cart/cart_viewmodel.dart';
import 'package:navalia_code_challenge/src/features/cart/views/cart_view.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_item.dart';

class MockCartViewmodel extends Mock implements CartViewmodel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CartView', () {
    late MockCartViewmodel mockViewmodel;

    setUpAll(() {
      mockViewmodel = MockCartViewmodel();
      SL.I.registerSingleton<CartViewmodel>(mockViewmodel);
    });

    setUp(() {
      when(() => mockViewmodel.state)
          .thenReturn(ValueNotifier<List<MenuItem>>([]));
    });

    tearDownAll(() {
      SL.I.reset();
    });

    testWidgets('shows empty cart message when cart is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CartView(),
        ),
      );

      expect(find.text('You have not added any products to your cart yet.'),
          findsOneWidget);
      expect(find.byIcon(Icons.error_outline_outlined), findsOneWidget);
    });

    testWidgets('displays product when cart is not empty',
        (WidgetTester tester) async {
      final item = MenuItem(
        id: 1,
        name: 'Product 1',
        description: 'Description 1',
        calories: '200',
        price: '10.00',
      );

      when(() => mockViewmodel.state)
          .thenReturn(ValueNotifier<List<MenuItem>>([item]));

      await tester.pumpWidget(
        const MaterialApp(
          home: CartView(),
        ),
      );

      expect(find.text('Product 1'), findsOneWidget);
    });

    testWidgets('removes product from cart when delete icon is tapped',
        (WidgetTester tester) async {
      final item = MenuItem(
        id: 1,
        name: 'Product 1',
        description: 'Description 1',
        calories: '200',
        price: '10.00',
      );

      when(() => mockViewmodel.state)
          .thenReturn(ValueNotifier<List<MenuItem>>([item]));

      await tester.pumpWidget(
        const MaterialApp(
          home: CartView(),
        ),
      );

      await tester.tap(find.byIcon(Icons.delete));
      verify(() => mockViewmodel.removeProduct(item)).called(1);
    });
  });
}
