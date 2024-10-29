import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/menu_catalog.dart';
import 'package:navalia_code_challenge/src/features/menu/domain/entities/sub_menu.dart';
import 'package:navalia_code_challenge/src/features/menu/ui/components/card_component.dart';
import 'package:navalia_code_challenge/src/features/menu/ui/menu_viewmodel.dart';
import 'package:navalia_code_challenge/src/features/menu/ui/views/menu_success_view.dart';

class MockMenuViewmodel extends Mock implements MenuViewmodel {}

void main() {
  late MockMenuViewmodel mockViewmodel;

  setUp(() {
    mockViewmodel = MockMenuViewmodel();
  });

  testWidgets(
      'MenuSuccessView displays grid of categories and navigates correctly',
      (WidgetTester tester) async {
    // Arrange
    final catalog = MenuCatalog(
      submenu: [
        SubMenu(
          id: 1,
          name: 'Category 1',
          titleTag: 'Category 1',
          menuItems: [1],
        ),
        SubMenu(
          id: 2,
          name: 'Category 2',
          titleTag: 'Category 2',
          menuItems: [1, 2],
        ),
        SubMenu(
          id: 3,
          name: 'Category 3',
          titleTag: 'Category 3',
          menuItems: [1, 2, 3],
        ),
      ],
      items: [],
    );

    // Configure GoRouter
    final mockRouter = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
              body: MenuSuccessView(
            catalog: catalog,
            viewmodel: mockViewmodel,
          )),
        ),
        GoRoute(
          path: '/products-by-category',
          builder: (context, state) {
            return Container();
          },
        ),
      ],
    );

    // Act
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: mockRouter,
      ),
    );

    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Category 1'), findsOneWidget);
    expect(find.text('Category 2'), findsOneWidget);
    expect(find.text('Category 3'), findsOneWidget);
    expect(find.byType(CardComponent), findsNWidgets(3));

    // Act
    await tester.tap(find.text('Category 1'));
    await tester.pumpAndSettle();

    // Assert: Checks if the onCategoryPicked function was called with the correct ID
    // and redirects to mock.
    verify(() => mockViewmodel.onCategoryPicked(1)).called(1);
    expect(find.byType(Container), findsOneWidget);
  });
}
