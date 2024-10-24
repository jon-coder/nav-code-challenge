import 'package:flutter/material.dart';
import 'package:navalia_code_challenge/src/core/ui/app_colors.dart';
import 'package:navalia_code_challenge/src/core/ui/text_styles.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({
    super.key,
    required this.title,
    this.action,
  });

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: context.textStyles.textBold.copyWith(color: AppColors.gray[0]),
      ),
      centerTitle: true,
      actions: action != null ? [action!] : [],
      backgroundColor: AppColors.primary,
      elevation: 0,
      toolbarHeight: kToolbarHeight,
      iconTheme: IconThemeData(color: AppColors.gray[0]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
