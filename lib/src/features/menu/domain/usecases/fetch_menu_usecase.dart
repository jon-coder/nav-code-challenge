import 'package:dartz/dartz.dart';

import '../../../../core/failures/api_failure.dart';
import '../entities/menu_catalog.dart';
import '../interfaces/menu_repository.dart';

class FetchMenuUsecase {
  FetchMenuUsecase(this.repository);
  final MenuRepository repository;

  Future<Either<Failure, MenuCatalog>> call() async => repository.fetchMenu();
}
