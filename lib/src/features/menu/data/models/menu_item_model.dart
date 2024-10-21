import '../../../../core/typedef/typedef.dart';
import '../../domain/entities/menu_item.dart';

class MenuItemModel extends MenuItem {
  MenuItemModel({
    required super.id,
    required super.name,
    required super.description,
    required super.calories,
    required super.price,
  });

  factory MenuItemModel.fromJson(Json json) {
    return MenuItemModel(
      id: json['menuItemId'] ?? '',
      name: json['displayName'] ?? '',
      description: json['description'] ?? '',
      calories: json['calorieRange'] ?? '',
      price: json['priceRange'] ?? '',
    );
  }
}
