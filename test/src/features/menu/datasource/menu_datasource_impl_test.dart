import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/core/failures/api_failure.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_failure.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_request_method.dart';
import 'package:navalia_code_challenge/src/core/network/domain/entities/network_response.dart';
import 'package:navalia_code_challenge/src/core/network/domain/interfaces/i_network.dart';
import 'package:navalia_code_challenge/src/core/typedef/typedef.dart';
import 'package:navalia_code_challenge/src/features/menu/datasource/menu_datasource_impl.dart';

class MockNetwork extends Mock implements INetwork {}

void main() {
  late INetwork mockNetwork;
  late MenuDatasourceImpl menuDatasource;

  setUp(() {
    mockNetwork = MockNetwork();
    menuDatasource = MenuDatasourceImpl(mockNetwork);
  });

  group('MenuDatasourceImpl', () {
    test('should return Json when network call is successful', () async {
      // Arrange
      final jsonResponse = {'key': 'value'};
      final networkResponse = NetworkResponse(
        jsonResponse,
        url: 'https://mockUrl',
        headers: {},
        method: NetworkRequestMethod.get,
        statusCode: 200,
      );

      when(() => mockNetwork.get(
            '/menu/getSiteMenu',
            queryParams: {
              'sourceCode': 'ORDER.WENDYS',
              'version': '22.1.2',
              'siteNum': 0,
            },
          )).thenAnswer((_) async => Right(networkResponse));

      // Act
      final result = await menuDatasource.fetchMenu();

      // Assert
      expect(result, isA<Right<ApiFailure, Json>>());
      expect(result.fold((l) => null, (r) => r), equals(jsonResponse));
      verify(() => mockNetwork.get(
            '/menu/getSiteMenu',
            queryParams: {
              'sourceCode': 'ORDER.WENDYS',
              'version': '22.1.2',
              'siteNum': 0,
            },
          )).called(1);
      verifyNoMoreInteractions(mockNetwork);
    });

    test('should return ApiFailure when network call fails', () async {
      // Arrange
      final networkFailure = NetworkFailure(
        message: 'Error',
        url: 'https://mockUrl',
        method: NetworkRequestMethod.get,
        statusCode: 404,
        type: HttpFailureType.notFound,
      );

      when(
        () => mockNetwork.get(
          '/menu/getSiteMenu',
          queryParams: {
            'sourceCode': 'ORDER.WENDYS',
            'version': '22.1.2',
            'siteNum': 0,
          },
        ),
      ).thenAnswer((_) async => Left(networkFailure));

      // Act
      final result = await menuDatasource.fetchMenu();

      // Assert
      expect(result, isA<Left<ApiFailure, Json>>());
      expect(result.fold((l) => l, (r) => null), isA<ApiFailure>());
      verify(() => mockNetwork.get(
            '/menu/getSiteMenu',
            queryParams: {
              'sourceCode': 'ORDER.WENDYS',
              'version': '22.1.2',
              'siteNum': 0,
            },
          )).called(1);
      verifyNoMoreInteractions(mockNetwork);
    });
  });
}
