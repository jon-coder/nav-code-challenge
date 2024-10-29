import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/core/failures/api_failure.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_catalog.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/interfaces/menu_repository.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/usecases/fetch_menu_usecase.dart';

class MockMenuRepository extends Mock implements MenuRepository {}

void main() {
  late MockMenuRepository mockMenuRepository;
  late FetchMenuUsecase fetchMenuUsecase;

  setUp(() {
    mockMenuRepository = MockMenuRepository();
    fetchMenuUsecase = FetchMenuUsecase(mockMenuRepository);
  });

  group('FetchMenuUsecase', () {
    test('should return MenuCatalog when repository fetch is successful',
        () async {
      // Arrange
      final menuCatalog = MenuCatalog(submenu: [], items: []);
      when(() => mockMenuRepository.fetchMenu())
          .thenAnswer((_) async => Right(menuCatalog));

      // Act
      final result = await fetchMenuUsecase.call();

      // Assert
      expect(result.isRight(), true);
      expect(result, Right(menuCatalog));
      verify(() => mockMenuRepository.fetchMenu()).called(1);
      verifyNoMoreInteractions(mockMenuRepository);
    });

    test('should return Failure when repository fetch fails', () async {
      // Arrange
      final failure = ApiFailure('An error occurred');
      when(() => mockMenuRepository.fetchMenu())
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await fetchMenuUsecase.call();

      // Assert
      expect(result.isLeft(), true);
      expect(result, Left(failure));
      verify(() => mockMenuRepository.fetchMenu()).called(1);
      verifyNoMoreInteractions(mockMenuRepository);
    });
  });
}
