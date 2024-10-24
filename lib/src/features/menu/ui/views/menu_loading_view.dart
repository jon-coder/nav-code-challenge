import 'package:flutter/material.dart';
import 'package:navalia_code_challenge/src/core/ui/app_colors.dart';

class MenuLoadingView extends StatelessWidget {
  const MenuLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}
