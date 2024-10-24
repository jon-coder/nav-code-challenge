import 'package:flutter/material.dart';

import '../../../../app_routes.dart';
import '../../../../core/service_locator/domain/interfaces/i_service_locator.dart';
import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/components/app_bar_component.dart';
import '../components/card_component.dart';
import '../menu_viewmodel.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({
    super.key,
    required this.selectedCategory,
  });

  final String selectedCategory;

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  late final MenuViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = SL.I<MenuViewmodel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray[10],
      appBar: AppBarComponent(
        title: widget.selectedCategory,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: viewmodel.productsByCategory.length,
          itemBuilder: (context, index) {
            final p = viewmodel.productsByCategory[index];
            return InkWell(
              onTap: () => {
                AppRoutes.go(
                  context,
                  RouteType.product,
                  args: {'product': p},
                )
              },
              child: CardComponent(
                label: p.name,
              ),
            );
          },
        ),
      ),
    );
  }
}
