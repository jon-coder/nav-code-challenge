import 'dart:async';

import '../../core/resources/app_resources.dart';
import '../../core/service_locator/domain/interfaces/i_service_locator.dart';
import 'cart_viewmodel.dart';

class SlCartFeature implements AppResources {
  @override
  FutureOr<void> initialize() {
    SL.I.registerSingleton<CartViewmodel>(
      CartViewmodel(),
    );
  }
}
