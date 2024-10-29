import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/sub_menu.dart';

void main() {
  group('SubMenu', () {
    late SubMenu subMenu;

    setUp(() {
      subMenu = SubMenu(
        id: 1,
        name: 'Beverages',
        titleTag: 'Beverages for Everyone',
        menuItems: [1, 2, 3],
      );
    });

    test('should have correct id', () {
      expect(subMenu.id, equals(1));
    });

    test('should have correct name', () {
      expect(subMenu.name, equals('Beverages'));
    });

    test('should have correct titleTag', () {
      expect(subMenu.titleTag, equals('Beverages for Everyone'));
    });

    test('should have correct menuItems', () {
      expect(subMenu.menuItems, equals([1, 2, 3]));
    });

    test('should have correct menuItems count', () {
      expect(subMenu.menuItems.length, equals(3));
    });
  });
}
