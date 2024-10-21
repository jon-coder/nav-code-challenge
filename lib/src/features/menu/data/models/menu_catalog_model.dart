import '../../../../core/typedef/typedef.dart';
import '../../domain/entities/menu_catalog.dart';
import 'menu_item_model.dart';
import 'sub_menu_model.dart';

class MenuCatalogModel extends MenuCatalog {
  MenuCatalogModel({
    required super.submenu,
    required super.items,
  });

  factory MenuCatalogModel.fromJson(Map<String, dynamic> json) {
    return MenuCatalogModel(
      submenu: (json['menuLists']['subMenus'] as List? ?? [])
          .map((e) => SubMenuModel.fromJson(e as Json))
          .toList(),
      items: (json['menuLists']['menuItems'] as List? ?? [])
          .map((e) => MenuItemModel.fromJson(e as Json))
          .toList(),
    );
  }
}
