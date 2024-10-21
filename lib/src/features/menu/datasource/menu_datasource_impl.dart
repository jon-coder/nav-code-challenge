import 'package:dartz/dartz.dart';

import '../../../core/failures/api_failure.dart';
import '../../../core/network/domain/interfaces/i_network.dart';
import '../../../core/typedef/typedef.dart';
import '../data/interfaces/menu_datasource.dart';

class MenuDatasourceImpl implements MenuDatasource {
  MenuDatasourceImpl(this.network);
  final INetwork network;

  @override
  Future<Either<ApiFailure, Json>> fetchMenu() async {
    final result = await network.get(
      '/menu/getSiteMenu',
      queryParams: {
        'sourceCode': 'ORDER.WENDYS',
        'version': '22.1.2',
        'siteNum': 0,
      },
    );
    return result.fold(
        (f) => Left(
              ApiFailure(
                '''Message: ${f.message}\n
                StatusCode: ${f.statusCode}\n
                Method ${f.method}''',
              ),
            ),
        (json) => Right(json.jsonData));
  }
}
