import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/features/menu/data/models/menu_item_model.dart';

void main() {
  group('MenuItemModel', () {
    test('fromJson should create a valid MenuItemModel', () {
      // Arrange
      final json = {
        'menuItemId': 1,
        'displayName': 'Cheeseburger',
        'description': 'A delicious cheeseburger',
        'calorieRange': '500-600',
        'priceRange': '5.99-7.99',
      };

      // Act
      final menuItemModel = MenuItemModel.fromJson(json);

      // Assert
      expect(menuItemModel.id, equals(1));
      expect(menuItemModel.name, equals('Cheeseburger'));
      expect(menuItemModel.description, equals('A delicious cheeseburger'));
      expect(menuItemModel.calories, equals('500-600'));
      expect(menuItemModel.price, equals('5.99-7.99'));
    });

    test('fromJson should handle missing keys gracefully', () {
      // Arrange
      final json = {
        'menuItemId': 1,
        'displayName': null,
        'calorieRange': null,
      };

      // Act
      final menuItemModel = MenuItemModel.fromJson(json);

      // Assert
      expect(menuItemModel.id, equals(1));
      expect(menuItemModel.name, equals(''));
      expect(menuItemModel.description, equals(''));
      expect(menuItemModel.calories, equals(''));
      expect(menuItemModel.price, equals(''));
    });
  });
}
