import 'package:dartz/dartz.dart';

import '../../../../core/failures/api_failure.dart';
import '../../domain/entities/menu_catalog.dart';
import '../../domain/interfaces/menu_repository.dart';
import '../interfaces/menu_datasource.dart';
import '../models/menu_catalog_model.dart';

class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl(this.datasource);
  final MenuDatasource datasource;

  @override
  Future<Either<Failure, MenuCatalog>> fetchMenu() async {
    try {
      final result = await datasource.fetchMenu();

      return result.fold(
        (failure) => Left(failure),
        (json) => Right(
          MenuCatalogModel.fromJson(json),
        ),
      );
    } catch (e) {
      return Left(ApiFailure('Error on fetch API: $e'));
    }
  }
}
