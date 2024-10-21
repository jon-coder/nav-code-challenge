import 'dart:async';

import 'package:flutter/material.dart';

import 'menu_page.dart';
import 'src/core/network/sl_network.dart';
import 'src/features/menu/sl_menu_feature.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MenuPage(),
    );
  }
}

FutureOr<void> init() async {
  await SlNetwork().initialize();
  await SlMenuFeature().initialize();
}
