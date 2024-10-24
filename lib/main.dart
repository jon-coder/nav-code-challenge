import 'dart:async';

import 'package:flutter/material.dart';

import 'src/app_routes.dart';
import 'src/core/network/sl_network.dart';
import 'src/core/ui/app_colors.dart';
import 'src/features/menu/sl_menu_feature.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Navalia Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
        useMaterial3: true,
      ),
      routerConfig: AppRoutes.goRoute,
    );
  }
}

FutureOr<void> init() async {
  await SlNetwork().initialize();
  await SlMenuFeature().initialize();
}
