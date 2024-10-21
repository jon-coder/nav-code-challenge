import 'package:dartz/dartz.dart';

import '../../../../core/failures/api_failure.dart';
import '../../../../core/typedef/typedef.dart';

abstract interface class MenuDatasource {
  Future<Either<Failure, Json>> fetchMenu();
}
