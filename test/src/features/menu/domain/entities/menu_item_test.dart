import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_item.dart';

void main() {
  group('MenuItem', () {
    late MenuItem menuItem;

    setUp(() {
      menuItem = MenuItem(
        id: 1,
        name: 'Hamburger',
        description: 'Delicious hamburger with cheese',
        calories: '500',
        price: '9.99',
      );
    });

    test('should have correct id', () {
      expect(menuItem.id, equals(1));
    });

    test('should have correct name', () {
      expect(menuItem.name, equals('Hamburger'));
    });

    test('should have correct description', () {
      expect(menuItem.description, equals('Delicious hamburger with cheese'));
    });

    test('should have correct calories', () {
      expect(menuItem.calories, equals('500'));
    });

    test('should have correct price', () {
      expect(menuItem.price, equals('9.99'));
    });
  });
}
