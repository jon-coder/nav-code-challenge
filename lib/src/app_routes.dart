import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/menu/ui/menu_page.dart';
import 'features/menu/ui/views/product_view.dart';
import 'features/menu/ui/views/products_list_view.dart';

class AppRoutes {
  static final goRoute = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MenuPage(),
      ),
      GoRoute(
        path: '/products-by-category',
        builder: (context, state) {
          final categoryArgs = state.extra as Map<String, dynamic>;
          return ProductsListView(
            selectedCategory: categoryArgs['category'],
          );
        },
      ),
      GoRoute(
        path: '/product',
        builder: (context, state) {
          final productArgs = state.extra as Map<String, dynamic>;
          return ProductView(
            product: productArgs['product'],
          );
        },
      ),
    ],
  );

  static void go(
    BuildContext ctx,
    RouteType routeType, {
    Object? args,
  }) {
    switch (routeType) {
      case RouteType.menu:
        GoRouter.of(ctx).go('/');
        break;
      case RouteType.productsCategory:
        GoRouter.of(ctx).push(
          '/products-by-category',
          extra: args,
        );
        break;
      case RouteType.product:
        GoRouter.of(ctx).push(
          '/product',
          extra: args,
        );
        break;
    }
  }
}

enum RouteType {
  menu,
  productsCategory,
  product,
}
