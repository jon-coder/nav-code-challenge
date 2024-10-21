import '../../../../core/typedef/typedef.dart';
import '../../domain/entities/sub_menu.dart';

class SubMenuModel extends SubMenu {
  SubMenuModel({
    required super.id,
    required super.name,
    required super.titleTag,
    required super.menuItems,
  });

  factory SubMenuModel.fromJson(Json json) {
    return SubMenuModel(
      id: json['subMenuId'] ?? '',
      name: json['displayName'] ?? '',
      titleTag: json['titleTag'] ?? '',
      menuItems: (json['menuItems'] as List?)
              ?.map<int>((item) => item as int)
              .toList() ??
          [],
    );
  }
}
