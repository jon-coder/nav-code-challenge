import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/components/app_bar_component.dart';
import '../../../../core/ui/text_styles.dart';
import '../../domain/entities/menu_item.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
    required this.product,
  });

  final MenuItem product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray[10],
      appBar: AppBarComponent(
        title: product.name,
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
              'Name: ${product.name}',
              style: context.textStyles.textMedium.copyWith(
                color: AppColors.gray[90],
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Description: ${product.description}',
              style: context.textStyles.textRegular.copyWith(
                color: AppColors.gray[90],
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            if (product.calories.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Calories: ${product.calories}',
                  style: context.textStyles.textRegular.copyWith(
                    color: AppColors.gray[90],
                    fontSize: 16,
                  ),
                ),
              ),
            Text(
              'Price: ${product.price}',
              style: context.textStyles.textRegular.copyWith(
                color: AppColors.gray[90],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
