import 'package:flutter_test/flutter_test.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_catalog.dart';
import 'package:navalia_code_challenge/src/features/menu/ui/menu_states.dart';

void main() {
  group('MenuState', () {
    test('MenuLoadingState should be created successfully', () {
      // Act
      final state = MenuLoadingState();

      // Assert
      expect(state, isA<MenuLoadingState>());
    });

    test('MenuErrorState should hold error message and tryAgain callback', () {
      // Arrange
      const errorMessage = 'An error occurred';
      void tryAgainCallback() {}

      // Act
      final state = MenuErrorState(errorMessage, tryAgainCallback);

      // Assert
      expect(state, isA<MenuErrorState>());
      expect(state.errorMessage, errorMessage);
      expect(state.tryAgain, tryAgainCallback);
    });

    test('MenuSuccessState should hold a valid MenuCatalog', () {
      // Arrange
      final catalog = MenuCatalog(
        submenu: [],
        items: [],
      );

      // Act
      final state = MenuSuccessState(catalog);

      // Assert
      expect(state, isA<MenuSuccessState>());
      expect(state.catalog, catalog);
    });
  });
}
