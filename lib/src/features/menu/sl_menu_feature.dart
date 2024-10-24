import 'dart:async';

import '../../core/network/domain/interfaces/i_network.dart';
import '../../core/resources/app_resources.dart';
import '../../core/service_locator/domain/interfaces/i_service_locator.dart';
import 'data/interfaces/menu_datasource.dart';
import 'data/repositories/menu_repository_impl.dart';
import 'datasource/menu_datasource_impl.dart';
import 'domain/interfaces/menu_repository.dart';
import 'domain/usecases/fetch_menu_usecase.dart';
import 'ui/menu_viewmodel.dart';

class SlMenuFeature implements AppResources {
  static const String baseUrl =
      'https://api.app.tst.wendys.digital/web-client-gateway';

  @override
  FutureOr<void> initialize() {
    SL.I.registerFactory<MenuDatasource>(
      () => MenuDatasourceImpl(INetwork(baseUrl)),
    );

    SL.I.registerFactory<MenuRepository>(
      () => MenuRepositoryImpl(
        SL.I<MenuDatasource>(),
      ),
    );

    SL.I.registerFactory<FetchMenuUsecase>(
      () => FetchMenuUsecase(
        SL.I<MenuRepository>(),
      ),
    );

    SL.I.registerSingleton<MenuViewmodel>(
      MenuViewmodel(
        fetchMenuUsecase: SL.I<FetchMenuUsecase>(),
      ),
    );
  }
}
