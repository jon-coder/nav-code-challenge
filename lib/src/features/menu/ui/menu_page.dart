import 'package:flutter/material.dart';

import '../../../core/extensions/presentation_extensions.dart';
import '../../../core/service_locator/domain/interfaces/i_service_locator.dart';
import '../../../core/ui/app_colors.dart';
import '../../../core/ui/components/app_bar_component.dart';
import '../../cart/views/cart_component.dart';
import 'menu_states.dart';
import 'menu_viewmodel.dart';
import 'views/menu_error_view.dart';
import 'views/menu_loading_view.dart';
import 'views/menu_success_view.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late final MenuViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = SL.I<MenuViewmodel>();
    viewmodel.loadAllMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray[10],
      appBar: const AppBarComponent(
        title: 'Categories Page',
        action: CartComponent(),
      ),
      body: viewmodel.state.observer(builder: (_, state, __) {
        if (state is MenuLoadingState) {
          return const MenuLoadingView();
        }
        if (state is MenuErrorState) {
          return MenuErrorView(
            errorMessage: state.errorMessage ?? 'Something got wrong',
            refresh: state.tryAgain,
          );
        }
        if (state is MenuSuccessState) {
          return MenuSuccessView(
            catalog: state.catalog,
            viewmodel: viewmodel,
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
