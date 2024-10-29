import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_catalog.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_item.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/sub_menu.dart';

class MockSubMenu extends Mock implements SubMenu {}

class MockMenuItem extends Mock implements MenuItem {}

void main() {
  group('MenuCatalog', () {
    late List<SubMenu> subMenus;
    late List<MenuItem> menuItems;
    late MenuCatalog menuCatalog;

    setUp(() {
      subMenus = [
        MockSubMenu(),
        MockSubMenu(),
      ];
      menuItems = [
        MockMenuItem(),
        MockMenuItem(),
      ];
      menuCatalog = MenuCatalog(submenu: subMenus, items: menuItems);
    });

    test('should initialize with given submenus', () {
      expect(menuCatalog.submenu, equals(subMenus));
    });

    test('should initialize with given menu items', () {
      expect(menuCatalog.items, equals(menuItems));
    });

    test('should have correct submenu count', () {
      expect(menuCatalog.submenu.length, equals(2));
    });

    test('should have correct menu item count', () {
      expect(menuCatalog.items.length, equals(2));
    });
  });
}
