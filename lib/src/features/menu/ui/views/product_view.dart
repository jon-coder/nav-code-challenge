import 'package:flutter/material.dart';

import '../../../../app_routes.dart';
import '../../../../core/service_locator/domain/interfaces/i_service_locator.dart';
import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/components/app_bar_component.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../cart/cart_viewmodel.dart';
import '../../domain/entities/menu_item.dart';

class ProductView extends StatefulWidget {
  const ProductView({
    super.key,
    required this.product,
  });

  final MenuItem product;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late final CartViewmodel _viewmodel;

  @override
  void initState() {
    super.initState();
    _viewmodel = SL.I<CartViewmodel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray[10],
      appBar: AppBarComponent(
        title: widget.product.name,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${widget.product.name}',
              style: context.textStyles.textMedium.copyWith(
                color: AppColors.gray[90],
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Description: ${widget.product.description}',
              style: context.textStyles.textRegular.copyWith(
                color: AppColors.gray[90],
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            if (widget.product.calories.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Calories: ${widget.product.calories}',
                  style: context.textStyles.textRegular.copyWith(
                    color: AppColors.gray[90],
                    fontSize: 16,
                  ),
                ),
              ),
            Text(
              'Price: ${widget.product.price}',
              style: context.textStyles.textRegular.copyWith(
                color: AppColors.gray[90],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsetsDirectional.only(
          end: 16,
          bottom: 32,
        ),
        child: FloatingActionButton(
          onPressed: () {
            _viewmodel.addProduct(widget.product);
            AppRoutes.go(
              context,
              RouteType.menu,
            );
          },
          backgroundColor: AppColors.primary[50],
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
