import 'package:dartz/dartz.dart';

import '../../../../core/failures/api_failure.dart';
import '../entities/menu_catalog.dart';

abstract interface class MenuRepository {
  Future<Either<Failure, MenuCatalog>> fetchMenu();
}
