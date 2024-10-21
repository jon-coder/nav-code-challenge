import 'menu_item.dart';
import 'sub_menu.dart';

class MenuCatalog {
  MenuCatalog({
    required this.submenu,
    required this.items,
  });

  List<SubMenu> submenu;
  List<MenuItem> items;
}
