import 'package:flutter/material.dart';

import '../domain/entities/menu_catalog.dart';

sealed class MenuState {}

class MenuLoadingState extends MenuState {}

class MenuErrorState extends MenuState {
  MenuErrorState(
    this.errorMessage,
    this.tryAgain,
  );
  final String? errorMessage;
  final VoidCallback tryAgain;
}

class MenuSuccessState extends MenuState {
  MenuSuccessState(this.catalog);
  final MenuCatalog catalog;
}
