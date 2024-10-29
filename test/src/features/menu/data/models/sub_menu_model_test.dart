import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/features/menu/data/models/sub_menu_model.dart';

void main() {
  group('SubMenuModel', () {
    test('fromJson should create a valid SubMenuModel', () {
      // Arrange
      final json = {
        'subMenuId': 1,
        'displayName': 'Beverages',
        'titleTag': 'Refreshing Drinks',
        'menuItems': [1, 2, 3],
      };

      // Act
      final subMenuModel = SubMenuModel.fromJson(json);

      // Assert
      expect(subMenuModel.id, equals(1));
      expect(subMenuModel.name, equals('Beverages'));
      expect(subMenuModel.titleTag, equals('Refreshing Drinks'));
      expect(subMenuModel.menuItems, equals([1, 2, 3]));
    });

    test('fromJson should handle missing keys gracefully', () {
      // Arrange
      final json = {
        'subMenuId': 1,
        'displayName': null,
        'menuItems': null,
      };

      // Act
      final subMenuModel = SubMenuModel.fromJson(json);

      // Assert
      expect(subMenuModel.id, equals(1));
      expect(subMenuModel.name, equals(''));
      expect(subMenuModel.titleTag, equals(''));
      expect(subMenuModel.menuItems, equals([]));
    });

    test('fromJson should handle empty menuItems list', () {
      // Arrange
      final json = {
        'subMenuId': 2,
        'displayName': 'Snacks',
        'titleTag': 'Tasty Treats',
        'menuItems': [],
      };

      // Act
      final subMenuModel = SubMenuModel.fromJson(json);

      // Assert
      expect(subMenuModel.id, equals(2));
      expect(subMenuModel.name, equals('Snacks'));
      expect(subMenuModel.titleTag, equals('Tasty Treats'));
      expect(subMenuModel.menuItems, equals([]));
    });
  });
}
