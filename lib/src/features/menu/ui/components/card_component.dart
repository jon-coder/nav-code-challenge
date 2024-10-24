import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/text_styles.dart';

class CardComponent extends StatelessWidget {
  const CardComponent({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 2,
      color: AppColors.gray[0],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          32.0,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 2,
          ),
          child: Text(
            label,
            style: context.textStyles.textRegular.copyWith(
              color: AppColors.gray[90],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
