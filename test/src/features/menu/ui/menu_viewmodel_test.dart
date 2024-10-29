import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/core/failures/api_failure.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_catalog.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_item.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/sub_menu.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/usecases/fetch_menu_usecase.dart';
import 'package:navalia_code_challenge/src/features/menu/ui/menu_states.dart';
import 'package:navalia_code_challenge/src/features/menu/ui/menu_viewmodel.dart';

class MockFetchMenuUsecase extends Mock implements FetchMenuUsecase {}

void main() {
  late MockFetchMenuUsecase mockFetchMenuUsecase;
  late MenuViewmodel menuViewmodel;

  setUp(() {
    mockFetchMenuUsecase = MockFetchMenuUsecase();
    menuViewmodel = MenuViewmodel(fetchMenuUsecase: mockFetchMenuUsecase);
  });

  group('MenuViewmodel', () {
    test('initial state should be MenuLoadingState', () {
      // Assert
      expect(menuViewmodel.state.value, isA<MenuLoadingState>());
    });

    test('loadAllMenu should set state to MenuErrorState on failure', () async {
      // Arrange
      final failure = ApiFailure('Error fetching menu');
      when(
        () => mockFetchMenuUsecase(),
      ).thenAnswer((_) async => Left(failure));

      // Act
      await menuViewmodel.loadAllMenu();

      // Assert
      expect(menuViewmodel.state.value, isA<MenuErrorState>());
      expect((menuViewmodel.state.value as MenuErrorState).errorMessage,
          'Error fetching menu');
      verify(() => mockFetchMenuUsecase()).called(1);
      verifyNoMoreInteractions(mockFetchMenuUsecase);
    });

    test('loadAllMenu should set state to MenuSuccessState on success',
        () async {
      // Arrange
      final menuCatalog = MenuCatalog(
        submenu: [],
        items: [],
      );
      when(() => mockFetchMenuUsecase())
          .thenAnswer((_) async => Right(menuCatalog));

      // Act
      await menuViewmodel.loadAllMenu();

      // Assert
      expect(menuViewmodel.state.value, isA<MenuSuccessState>());
      expect(
          (menuViewmodel.state.value as MenuSuccessState).catalog, menuCatalog);
      expect(menuViewmodel.menuData, menuCatalog);
      verify(() => mockFetchMenuUsecase()).called(1);
      verifyNoMoreInteractions(mockFetchMenuUsecase);
    });

    test('onCategoryPicked should update productsByCategory', () {
      // Arrange
      final menuCatalog = MenuCatalog(
        submenu: [
          SubMenu(
              id: 1, name: 'Beverages', titleTag: 'Drinks', menuItems: [1, 2]),
        ],
        items: [
          MenuItem(
              id: 1, name: 'Coke', description: '', calories: '', price: ''),
          MenuItem(
              id: 2, name: 'Fries', description: '', calories: '', price: ''),
        ],
      );
      menuViewmodel.menuData = menuCatalog;

      // Act
      menuViewmodel.onCategoryPicked(1);

      // Assert
      expect(menuViewmodel.productsByCategory.length, 2);
      expect(menuViewmodel.productsByCategory[0].name, 'Coke');
      expect(menuViewmodel.productsByCategory[1].name, 'Fries');
    });
  });
}
