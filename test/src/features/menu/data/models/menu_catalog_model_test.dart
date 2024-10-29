import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/features/menu/data/models/menu_catalog_model.dart';

void main() {
  group('MenuCatalogModel', () {
    test('fromJson should create a valid MenuCatalogModel', () {
      // Arrange
      final json = {
        'menuLists': {
          'subMenus': [
            {
              'subMenuId': 1,
              'displayName': 'Beverages',
              'titleTag': 'Refreshing Drinks',
              'menuItems': [1, 2],
            }
          ],
          'menuItems': [
            {
              'menuItemId': 1,
              'displayName': 'Coke',
              'description': 'A refreshing soda',
              'calorieRange': '150',
              'priceRange': '1.50',
            },
            {
              'menuItemId': 2,
              'displayName': 'Fries',
              'description': 'Crispy fries',
              'calorieRange': '300',
              'priceRange': '2.50',
            },
          ],
        },
      };

      // Act
      final menuCatalogModel = MenuCatalogModel.fromJson(json);

      // Assert
      expect(menuCatalogModel.submenu.length, equals(1));
      expect(menuCatalogModel.items.length, equals(2));

      expect(menuCatalogModel.submenu[0].id, equals(1));
      expect(menuCatalogModel.submenu[0].name, equals('Beverages'));

      expect(menuCatalogModel.items[0].id, equals(1));
      expect(menuCatalogModel.items[0].name, equals('Coke'));
      expect(menuCatalogModel.items[1].id, equals(2));
      expect(menuCatalogModel.items[1].name, equals('Fries'));
    });

    test('fromJson should handle missing keys gracefully', () {
      // Arrange
      final json = {
        'menuLists': {
          'subMenus': null,
          'menuItems': null,
        },
      };

      // Act
      final menuCatalogModel = MenuCatalogModel.fromJson(json);

      // Assert
      expect(menuCatalogModel.submenu, equals([]));
      expect(menuCatalogModel.items, equals([]));
    });

    test('fromJson should handle empty menuLists', () {
      // Arrange
      final json = {
        'menuLists': {
          'subMenus': [],
          'menuItems': [],
        },
      };

      // Act
      final menuCatalogModel = MenuCatalogModel.fromJson(json);

      // Assert
      expect(menuCatalogModel.submenu, equals([]));
      expect(menuCatalogModel.items, equals([]));
    });
  });
}
