import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/core/network/domain/interfaces/i_network.dart';
import 'package:navalia_code_challenge/src/core/service_locator/domain/interfaces/i_service_locator.dart';
import 'package:navalia_code_challenge/src/features/menu/data/interfaces/menu_datasource.dart';
import 'package:navalia_code_challenge/src/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:navalia_code_challenge/src/features/menu/datasource/menu_datasource_impl.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/interfaces/menu_repository.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/usecases/fetch_menu_usecase.dart';
import 'package:navalia_code_challenge/src/features/menu/sl_menu_feature.dart';
import 'package:navalia_code_challenge/src/features/menu/ui/menu_viewmodel.dart';

class _MockINetwork extends Mock implements INetwork {}

void main() {
  group('SlMenuFeature', () {
    late SlMenuFeature slMenuFeature;
    late INetwork networkDriver;

    setUp(() async {
      SL.I.reset();
      networkDriver = _MockINetwork();
      slMenuFeature = SlMenuFeature();
    });

    test('should register MenuDatasource on initialization', () async {
      SL.I.registerFactory<INetwork>(() => networkDriver);
      await slMenuFeature.initialize();
      expect(SL.I<MenuDatasource>(), isA<MenuDatasourceImpl>());
      verifyNoMoreInteractions(networkDriver);
    });

    test('should register MenuRepository on initialization', () async {
      SL.I.registerFactory<INetwork>(() => networkDriver);
      await slMenuFeature.initialize();
      expect(SL.I<MenuRepository>(), isA<MenuRepositoryImpl>());
      verifyNoMoreInteractions(networkDriver);
    });

    test('should register FetchMenuUsecase on initialization', () async {
      SL.I.registerFactory<INetwork>(() => networkDriver);
      await slMenuFeature.initialize();
      expect(SL.I<FetchMenuUsecase>(), isA<FetchMenuUsecase>());
      verifyNoMoreInteractions(networkDriver);
    });

    test('should register MenuViewmodel on initialization', () async {
      SL.I.registerFactory<INetwork>(() => networkDriver);
      await slMenuFeature.initialize();
      expect(SL.I<MenuViewmodel>(), isA<MenuViewmodel>());
      verifyNoMoreInteractions(networkDriver);
    });
  });
}
