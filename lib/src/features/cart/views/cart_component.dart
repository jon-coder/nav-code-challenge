import 'package:flutter/material.dart';

import '../../../app_routes.dart';
import '../../../core/extensions/presentation_extensions.dart';
import '../../../core/service_locator/domain/interfaces/i_service_locator.dart';
import '../../../core/ui/app_colors.dart';
import '../../../core/ui/text_styles.dart';
import '../cart_viewmodel.dart';

class CartComponent extends StatefulWidget {
  const CartComponent({super.key});

  @override
  State<CartComponent> createState() => _CartComponentState();
}

class _CartComponentState extends State<CartComponent> {
  late final CartViewmodel cartViewmodel;

  @override
  void initState() {
    super.initState();
    cartViewmodel = SL.I<CartViewmodel>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: cartViewmodel.state.observer(
        builder: (_, state, __) {
          return InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            splashColor: AppColors.gray[5],
            highlightColor: Colors.transparent,
            onTap: () {
              AppRoutes.go(
                context,
                RouteType.cart,
              );
            },
            child: SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 40,
                  ),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary[40],
                      ),
                      child: Center(
                        child: Text(
                          _getItemsValue(state.length),
                          style: context.textStyles.textBold.copyWith(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getItemsValue(int items) {
    if (items < 10) {
      return items.toString();
    }
    return '9+';
  }
}
