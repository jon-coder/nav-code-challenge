import 'package:flutter/material.dart';

import '../../../../app_routes.dart';
import '../../domain/entities/menu_catalog.dart';
import '../components/card_component.dart';
import '../menu_viewmodel.dart';

class MenuSuccessView extends StatelessWidget {
  const MenuSuccessView({
    super.key,
    required this.catalog,
    required this.viewmodel,
  });

  final MenuCatalog catalog;
  final MenuViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: catalog.submenu.length,
        itemBuilder: (context, index) {
          final category = catalog.submenu[index];
          return InkWell(
            onTap: () {
              viewmodel.onCategoryPicked(category.id);
              AppRoutes.go(
                context,
                RouteType.productsCategory,
                args: {'category': category.name},
              );
            },
            child: CardComponent(
              label: category.name,
            ),
          );
        },
      ),
    );
  }
}
