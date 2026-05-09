import 'package:abasto/core/constants/list_types.dart';
import 'package:abasto/features/lists/domain/entities/category_entity.dart';
import 'package:abasto/features/lists/domain/entities/shopping_item.dart';
import 'package:abasto/features/lists/domain/entities/shopping_item_draft.dart';
import 'package:abasto/features/lists/domain/entities/shopping_list.dart';
import 'package:abasto/features/lists/domain/repositories/shopping_repository.dart';
import 'package:abasto/features/lists/presentation/providers/shopping_providers.dart';
import 'package:abasto/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('renders auth flow and opens the Abasto shell', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          shoppingRepositoryProvider.overrideWithValue(
            _FakeShoppingRepository(),
          ),
        ],
        child: const AbastoApp(),
      ),
    );
    await tester.pump();

    expect(find.text('Abasto'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2300));
    await tester.pumpAndSettle();

    expect(find.text('Continuar como invitado'), findsOneWidget);

    await tester.ensureVisible(find.text('Continuar como invitado'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continuar como invitado'));
    await tester.pumpAndSettle();

    expect(find.text('Inicio'), findsOneWidget);
    expect(find.text('Listas'), findsOneWidget);
    expect(find.text('Historial'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);
  });
}

class _FakeShoppingRepository implements ShoppingRepository {
  @override
  Stream<List<CategoryEntity>> watchCategories() => const Stream.empty();

  @override
  Stream<List<ShoppingList>> watchActiveLists({ListType? type, int? limit}) {
    return Stream.value(const []);
  }

  @override
  Stream<List<ShoppingList>> watchFinishedLists({ListType? type}) {
    return Stream.value(const []);
  }

  @override
  Stream<ShoppingList?> watchList(String id) => Stream.value(null);

  @override
  Stream<List<ShoppingItem>> watchItems(String listId) {
    return Stream.value(const []);
  }

  @override
  Future<ShoppingList> createList({
    required ListType type,
    required String name,
    String? storeName,
    List<ShoppingItemDraft> items = const [],
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateList({
    required String id,
    required String name,
    String? storeName,
  }) async {}

  @override
  Future<String> duplicateList(String id) async => id;

  @override
  Future<void> finishList(String id) async {}

  @override
  Future<void> deleteList(String id) async {}

  @override
  Future<void> clearHistory({ListType? type}) async {}

  @override
  Future<void> addItem({
    required String listId,
    required ShoppingItemDraft draft,
  }) async {}

  @override
  Future<void> updateItem({
    required String id,
    required ShoppingItemDraft draft,
  }) async {}

  @override
  Future<void> toggleItem({
    required String id,
    required bool isChecked,
  }) async {}

  @override
  Future<void> deleteItem(String id) async {}
}
