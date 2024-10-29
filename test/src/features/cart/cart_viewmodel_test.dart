import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/features/cart/cart_viewmodel.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_item.dart';

void main() {
  group('CartViewmodel', () {
    late CartViewmodel cartViewmodel;

    setUp(() {
      cartViewmodel = CartViewmodel();
    });

    test('Initial cart state is empty', () {
      expect(cartViewmodel.state.value, isEmpty);
    });

    test('Adding a product updates the cart', () {
      final item = MenuItem(
        id: 1,
        name: 'Product 1',
        description: 'Description 1',
        calories: '200',
        price: '10.00',
      );
      cartViewmodel.addProduct(item);

      expect(cartViewmodel.state.value, contains(item));
      expect(cartViewmodel.state.value.length, 1);
    });

    test('Removing a product updates the cart', () {
      final item = MenuItem(
        id: 1,
        name: 'Product 1',
        description: 'Description 1',
        calories: '200',
        price: '10.00',
      );
      cartViewmodel.addProduct(item);
      cartViewmodel.removeProduct(item);

      expect(cartViewmodel.state.value, isNot(contains(item)));
      expect(cartViewmodel.state.value.length, 0);
    });

    test('Removing a non-existent product does not change the cart', () {
      final item1 = MenuItem(
        id: 1,
        name: 'Product 1',
        description: 'Description 1',
        calories: '200',
        price: '10.00',
      );
      final item2 = MenuItem(
        id: 2,
        name: 'Product 2',
        description: 'Description 2',
        calories: '300',
        price: '15.00',
      );
      cartViewmodel.addProduct(item1);
      cartViewmodel.removeProduct(item2);

      expect(cartViewmodel.state.value, contains(item1));
      expect(cartViewmodel.state.value.length, 1);
    });
  });
}
