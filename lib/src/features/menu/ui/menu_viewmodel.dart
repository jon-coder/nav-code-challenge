import 'package:flutter/foundation.dart';

import '../../../core/extensions/presentation_extensions.dart';
import '../domain/entities/menu_catalog.dart';
import '../domain/entities/menu_item.dart';
import '../domain/usecases/fetch_menu_usecase.dart';
import 'menu_states.dart';

class MenuViewmodel {
  MenuViewmodel({
    required FetchMenuUsecase fetchMenuUsecase,
  }) : _fetchMenuUsecase = fetchMenuUsecase;

  final FetchMenuUsecase _fetchMenuUsecase;

  final _state = ValueNotifier<MenuState>(MenuLoadingState());
  ValueListenable<MenuState> get state => _state;

  late final MenuCatalog menuData;
  Future<void> loadAllMenu() async {
    _state.setValue(MenuLoadingState());

    final result = await _fetchMenuUsecase();

    result.fold(
      (failure) => _state.setValue(
        MenuErrorState(
          failure.message,
          _refreshAllMenu,
        ),
      ),
      (loadedMenu) {
        menuData = loadedMenu;
        _state.setValue(
          MenuSuccessState(loadedMenu),
        );
      },
    );
  }

  Future<void> _refreshAllMenu() async => loadAllMenu();

  final List<MenuItem> _productsByCategory = [];
  List<MenuItem> get productsByCategory => _productsByCategory;
  void onCategoryPicked(int index) {
    _productsByCategory.clear();

    final categoryPicked = menuData.submenu.firstWhere((c) => index == c.id);
    _productsByCategory.addAll(categoryPicked.menuItems.map(
      (id) {
        return menuData.items.firstWhere(
          (product) => product.id == id,
        );
      },
    ).whereType<MenuItem>());
  }
}
