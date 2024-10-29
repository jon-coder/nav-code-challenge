import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/core/failures/api_failure.dart';
import 'package:navalia_code_challenge/src/features/menu/data/interfaces/menu_datasource.dart';
import 'package:navalia_code_challenge/src/features/menu/data/models/menu_catalog_model.dart';
import 'package:navalia_code_challenge/src/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_catalog.dart';

class MockMenuDatasource extends Mock implements MenuDatasource {}

void main() {
  late MockMenuDatasource mockMenuDatasource;
  late MenuRepositoryImpl menuRepository;

  setUp(() {
    mockMenuDatasource = MockMenuDatasource();
    menuRepository = MenuRepositoryImpl(mockMenuDatasource);
  });

  group('MenuRepositoryImpl', () {
    test('should return MenuCatalogModel when datasource fetch is successful',
        () async {
      // Arrange
      final jsonResponse = {
        'menuLists': {
          'subMenus': [
            {
              'subMenuId': 1,
              'displayName': 'Beverages',
              'titleTag': 'Refreshing Drinks',
              'menuItems': [1, 2],
            }
          ],
          'menuItems': [
            {
              'menuItemId': 1,
              'displayName': 'Coke',
              'description': 'A refreshing soda',
              'calorieRange': '150',
              'priceRange': '1.50',
            },
            {
              'menuItemId': 2,
              'displayName': 'Fries',
              'description': 'Crispy fries',
              'calorieRange': '300',
              'priceRange': '2.50',
            },
          ],
        },
      };

      when(() => mockMenuDatasource.fetchMenu())
          .thenAnswer((_) async => Right(jsonResponse));

      // Act
      final result = await menuRepository.fetchMenu();

      // Assert
      expect(result, isA<Right<Failure, MenuCatalog>>());
      expect(result.fold((l) => null, (r) => r), isA<MenuCatalogModel>());
      verify(() => menuRepository.fetchMenu()).called(1);
      verifyNoMoreInteractions(mockMenuDatasource);
    });

    test('should return Failure when datasource fetch fails', () async {
      // Arrange
      final failure = ApiFailure('Datasource error');
      when(() => mockMenuDatasource.fetchMenu())
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await menuRepository.fetchMenu();

      // Assert
      expect(result, Left(failure));
      verify(() => menuRepository.fetchMenu()).called(1);
      verifyNoMoreInteractions(mockMenuDatasource);
    });

    test('should return ApiFailure when an exception occurs', () async {
      // Arrange
      when(() => mockMenuDatasource.fetchMenu())
          .thenThrow(Exception('Unexpected error'));

      // Act
      final result = await menuRepository.fetchMenu();

      // Assert
      expect(result, isA<Left<Failure, MenuCatalog>>());
      expect(result.fold((l) => l, (r) => null), isA<ApiFailure>());
      verify(() => menuRepository.fetchMenu()).called(1);
      verifyNoMoreInteractions(mockMenuDatasource);
    });
  });
}
