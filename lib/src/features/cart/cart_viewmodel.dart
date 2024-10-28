import 'package:flutter/foundation.dart';

import '../../core/extensions/presentation_extensions.dart';
import '../menu/domain/entities/menu_item.dart';

class CartViewmodel {
  final _cart = ValueNotifier<List<MenuItem>>([]);
  ValueListenable<List<MenuItem>> get state => _cart;

  void addProduct(MenuItem p) {
    _cart.setValue(List.from(_cart.value)..add(p));
  }

  void removeProduct(MenuItem p) {
    _cart.setValue(List.from(_cart.value)..remove(p));
  }
}
