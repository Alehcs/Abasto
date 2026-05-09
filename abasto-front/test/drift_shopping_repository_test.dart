import 'package:abasto/core/constants/categories.dart';
import 'package:abasto/core/constants/list_types.dart';
import 'package:abasto/core/database/app_database.dart';
import 'package:abasto/features/lists/data/repositories/drift_shopping_repository.dart';
import 'package:abasto/features/lists/domain/entities/shopping_item_draft.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late DriftShoppingRepository ownerRepository;
  late DriftShoppingRepository otherRepository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    ownerRepository = DriftShoppingRepository(
      database,
      currentUserId: 'owner-user',
    );
    otherRepository = DriftShoppingRepository(
      database,
      currentUserId: 'other-user',
    );
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'creates owned lists and keeps unpriced items without adding to total',
    () async {
      final list = await ownerRepository.createList(
        type: ListType.supermercado,
        name: 'Compra semanal',
        storeName: 'Lider',
      );

      await ownerRepository.addItem(
        listId: list.id,
        draft: ShoppingItemDraft(
          name: 'Leche',
          categoryId: DefaultCategories.lacteos.id,
        ),
      );

      final active = await ownerRepository.watchActiveLists().first;

      expect(active, hasLength(1));
      expect(active.single.ownerId, 'owner-user');
      expect(active.single.canDelete, isTrue);
      expect(active.single.totalItems, 1);
      expect(active.single.pendingItems, 1);
      expect(active.single.total, 0);
    },
  );

  test(
    'finishing an empty list discards it instead of saving history',
    () async {
      final list = await ownerRepository.createList(
        type: ListType.feria,
        name: 'Feria vacia',
      );

      await ownerRepository.finishList(list.id);

      expect(await ownerRepository.watchActiveLists().first, isEmpty);
      expect(await ownerRepository.watchFinishedLists().first, isEmpty);
    },
  );

  test('deleteList only allows the owner to delete', () async {
    final list = await ownerRepository.createList(
      type: ListType.supermercado,
      name: 'Lista del dueno',
      items: [
        ShoppingItemDraft(
          name: 'Arroz',
          price: 1200,
          categoryId: DefaultCategories.pastasArroz.id,
        ),
      ],
    );

    await ownerRepository.finishList(list.id);

    expect(
      () => otherRepository.deleteList(list.id),
      throwsA(isA<StateError>()),
    );

    final history = await ownerRepository.watchFinishedLists().first;

    expect(history, hasLength(1));
    expect(history.single.id, list.id);
    expect(history.single.canDelete, isTrue);
  });

  test('clearHistory removes only the current user history', () async {
    final ownerList = await ownerRepository.createList(
      type: ListType.supermercado,
      name: 'Historia propia',
      items: [
        ShoppingItemDraft(
          name: 'Fideos',
          price: 990,
          categoryId: DefaultCategories.pastasArroz.id,
        ),
      ],
    );
    final otherList = await otherRepository.createList(
      type: ListType.feria,
      name: 'Historia ajena',
      items: [
        ShoppingItemDraft(
          name: 'Tomate',
          price: 1500,
          categoryId: DefaultCategories.verduras.id,
        ),
      ],
    );

    await ownerRepository.finishList(ownerList.id);
    await otherRepository.finishList(otherList.id);
    await ownerRepository.clearHistory();

    final remaining = await ownerRepository.watchFinishedLists().first;

    expect(remaining.map((list) => list.id), isNot(contains(ownerList.id)));
    expect(remaining.map((list) => list.id), contains(otherList.id));
    expect(remaining.single.canDelete, isFalse);
  });

  test('clearHistory can remove only supermarket history', () async {
    final supermarket = await ownerRepository.createList(
      type: ListType.supermercado,
      name: 'Super propia',
      items: [
        ShoppingItemDraft(
          name: 'Azucar',
          price: 1100,
          categoryId: DefaultCategories.azucarReposteria.id,
        ),
      ],
    );
    final fair = await ownerRepository.createList(
      type: ListType.feria,
      name: 'Feria propia',
      items: [
        ShoppingItemDraft(
          name: 'Manzana',
          price: 1800,
          categoryId: DefaultCategories.frutas.id,
        ),
      ],
    );

    await ownerRepository.finishList(supermarket.id);
    await ownerRepository.finishList(fair.id);
    await ownerRepository.clearHistory(type: ListType.supermercado);

    final remaining = await ownerRepository.watchFinishedLists().first;

    expect(remaining.map((list) => list.id), isNot(contains(supermarket.id)));
    expect(remaining.map((list) => list.id), contains(fair.id));
  });
}
