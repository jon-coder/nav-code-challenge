import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/core/service_locator/domain/interfaces/i_service_locator.dart';
import 'package:navalia_code_challenge/src/features/cart/cart_viewmodel.dart';
import 'package:navalia_code_challenge/src/features/cart/views/cart_component.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_item.dart';
import 'package:go_router/go_router.dart';

class MockCartViewmodel extends Mock implements CartViewmodel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCartViewmodel mockViewmodel;

  setUpAll(() {
    mockViewmodel = MockCartViewmodel();
    SL.I.registerSingleton<CartViewmodel>(mockViewmodel);
  });

  testWidgets('displays correct item count and navigates on tap',
      (WidgetTester tester) async {
    // Arrange
    final cartItems = ValueNotifier<List<MenuItem>>([]);
    when(() => mockViewmodel.state).thenReturn(cartItems);

    final mockRouter = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(
            body: CartComponent(),
          ),
        ),
        GoRoute(
          path: '/my-cart',
          builder: (context, state) {
            return Container();
          },
        ),
      ],
    );

    // Act
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: mockRouter,
      ),
    );

    // Assert: Verify empty state of cart
    expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // Arrange: Updates the mock state to have 1 item
    final item = MenuItem(
      id: 1,
      name: 'Item 1',
      description: 'Description 1',
      calories: '100',
      price: '5.00',
    );

    when(() => mockViewmodel.addProduct(item)).thenAnswer((_) {
      cartItems.value = List.from(cartItems.value)..add(item);
    });

    // Act: Add item to cart
    mockViewmodel.addProduct(item);
    await tester.pumpAndSettle();

    // Assert: Checks if the quantity of items has been updated to 1
    expect(find.text('1'), findsOneWidget);

    // Act: Simulate a click
    await tester.tap(find.byType(Icon));
    await tester.pumpAndSettle();

    // Assert: Verify that navigation to the cart route occurred
    expect(find.byType(Container), findsOneWidget);
  });
}
