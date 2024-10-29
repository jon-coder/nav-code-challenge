import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/core/service_locator/domain/interfaces/i_service_locator.dart';
import 'package:navalia_code_challenge/src/features/cart/cart_viewmodel.dart';
import 'package:navalia_code_challenge/src/features/cart/sl_cart_feature.dart';

void main() {
  group('SlCartFeature', () {
    late SlCartFeature slCartFeature;

    setUp(() {
      SL.I.reset();
      slCartFeature = SlCartFeature();
    });

    test('should register CartViewmodel on initialization', () async {
      await slCartFeature.initialize();
      expect(SL.I<CartViewmodel>(), isA<CartViewmodel>());
    });
  });
}
