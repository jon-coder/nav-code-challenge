import 'package:flutter/material.dart';
import 'package:navalia_code_challenge/src/core/ui/text_styles.dart';

import '../../../core/service_locator/domain/interfaces/i_service_locator.dart';
import '../../../core/ui/app_colors.dart';
import '../../../core/ui/components/app_bar_component.dart';
import '../cart_viewmodel.dart';

class CartView extends StatefulWidget {
  const CartView({
    super.key,
  });

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late final CartViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = SL.I<CartViewmodel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray[10],
      appBar: const AppBarComponent(title: 'My Cart'),
      body: ValueListenableBuilder(
        valueListenable: viewmodel.state,
        builder: (context, cart, child) {
          if (cart.isEmpty) {
            return const _EmptyCartComponent();
          }
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final product = viewmodel.state.value[index];
                    return Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(product.name),
                          trailing: InkWell(
                            onTap: () {
                              viewmodel.removeProduct(product);
                            },
                            child: const Icon(Icons.delete),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: viewmodel.state.value.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyCartComponent extends StatelessWidget {
  const _EmptyCartComponent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have not added any products to your cart yet.',
              style: context.textStyles.textSemiBold.copyWith(
                color: AppColors.gray[80],
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 16,
            ),
            Icon(
              Icons.error_outline_outlined,
              size: 56,
              color: AppColors.primary[50],
            ),
          ],
        ),
      ),
    );
  }
}
