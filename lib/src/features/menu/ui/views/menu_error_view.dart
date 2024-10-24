import 'package:flutter/material.dart';

import '../../../../core/ui/app_colors.dart';
import '../../../../core/ui/text_styles.dart';

class MenuErrorView extends StatelessWidget {
  const MenuErrorView({
    super.key,
    required this.errorMessage,
    required this.refresh,
  });

  final String errorMessage;
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: context.textStyles.textSemiBold.copyWith(
              color: AppColors.gray[80],
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Icon(
            Icons.error_outline_outlined,
            size: 56,
            color: AppColors.primary[50],
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: refresh,
            child: Text(
              'TRY AGAIN',
              style: context.textStyles.textButtonLabel,
            ),
          ),
        ],
      ),
    );
  }
}
