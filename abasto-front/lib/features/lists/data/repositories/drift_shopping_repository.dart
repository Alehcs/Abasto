import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';

import '../../../../core/constants/list_types.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/services/sync_status.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/shopping_item.dart';
import '../../domain/entities/shopping_item_draft.dart';
import '../../domain/entities/shopping_list.dart';
import '../../domain/repositories/shopping_repository.dart';

class DriftShoppingRepository implements ShoppingRepository {
  DriftShoppingRepository(this._db, {required String currentUserId})
    : _currentUserId = currentUserId;

  final AppDatabase _db;
  final String _currentUserId;
  final Random _random = Random();

  @override
  Stream<List<CategoryEntity>> watchCategories() {
    final query = _db.select(_db.categories)
      ..orderBy([(table) => OrderingTerm.asc(table.order)]);

    return query.watch().map((rows) => rows.map(_mapCategory).toList());
  }

  @override
  Stream<List<ShoppingList>> watchActiveLists({ListType? type, int? limit}) {
    return _watchLists(finished: false, type: type, limit: limit);
  }

  @override
  Stream<List<ShoppingList>> watchFinishedLists({ListType? type}) {
    return _watchLists(finished: true, type: type);
  }

  @override
  Stream<ShoppingList?> watchList(String id) {
    final query = _db.select(_db.shoppingLists).join([
      leftOuterJoin(
        _db.shoppingItems,
        _db.shoppingItems.listId.equalsExp(_db.shoppingLists.id) &
            _db.shoppingItems.deletedAt.isNull(),
      ),
    ]);

    query.where(
      _db.shoppingLists.id.equals(id) & _db.shoppingLists.deletedAt.isNull(),
    );

    return query.watch().map((rows) {
      final lists = _mapJoinedRows(rows);
      return lists.isEmpty ? null : lists.first;
    });
  }

  @override
  Stream<List<ShoppingItem>> watchItems(String listId) {
    final query = _db.select(_db.shoppingItems)
      ..where((table) => table.listId.equals(listId) & table.deletedAt.isNull())
      ..orderBy([
        (table) => OrderingTerm.asc(table.categoryId),
        (table) => OrderingTerm.asc(table.createdAt),
      ]);

    return query.watch().map((rows) => rows.map(_mapItem).toList());
  }

  @override
  Future<ShoppingList> createList({
    required ListType type,
    required String name,
    String? storeName,
    List<ShoppingItemDraft> items = const [],
  }) async {
    final now = DateTime.now();
    final listId = _newId('list');
    final normalizedName = _fallbackName(type, name);
    final normalizedStoreName = type.isSupermarket
        ? _emptyToNull(storeName)
        : null;

    await _db.transaction(() async {
      await _db
          .into(_db.shoppingLists)
          .insert(
            ShoppingListsCompanion.insert(
              id: listId,
              type: type.name,
              name: normalizedName,
              storeName: Value(normalizedStoreName),
              createdAt: now,
              updatedAt: now,
              ownerId: Value(_currentUserId),
              sharedWith: const Value('[]'),
              syncStatus: Value(SyncStatus.local.name),
            ),
          );

      for (final draft in items.where(
        (draft) => draft.name.trim().isNotEmpty,
      )) {
        await _insertItem(listId: listId, draft: draft, now: now);
      }
    });

    return ShoppingList(
      id: listId,
      type: type,
      name: normalizedName,
      storeName: normalizedStoreName,
      createdAt: now,
      updatedAt: now,
      ownerId: _currentUserId,
      totalItems: items.length,
      pendingItems: items.length,
      pendingItemNames: items.map((item) => item.name.trim()).toList(),
    );
  }

  @override
  Future<void> updateList({
    required String id,
    required String name,
    String? storeName,
  }) async {
    final list = await _listRowById(id);
    if (list == null) return;

    await (_db.update(
      _db.shoppingLists,
    )..where((table) => table.id.equals(id))).write(
      ShoppingListsCompanion(
        name: Value(
          _fallbackName(ListTypeParser.fromDatabase(list.type), name),
        ),
        storeName: Value(
          ListTypeParser.fromDatabase(list.type).isSupermarket
              ? _emptyToNull(storeName)
              : null,
        ),
        updatedAt: Value(DateTime.now()),
        syncStatus: Value(SyncStatus.local.name),
      ),
    );
  }

  @override
  Future<String> duplicateList(String id) async {
    final source = await _listRowById(id);
    if (source == null) {
      throw StateError('La lista no existe.');
    }

    final items =
        await (_db.select(_db.shoppingItems)..where(
              (table) => table.listId.equals(id) & table.deletedAt.isNull(),
            ))
            .get();

    final now = DateTime.now();
    final newListId = _newId('list');

    await _db.transaction(() async {
      await _db
          .into(_db.shoppingLists)
          .insert(
            ShoppingListsCompanion.insert(
              id: newListId,
              type: source.type,
              name: 'Copia de ${source.name}',
              storeName: Value(source.storeName),
              createdAt: now,
              updatedAt: now,
              ownerId: Value(_currentUserId),
              sharedWith: const Value('[]'),
              syncStatus: Value(SyncStatus.local.name),
            ),
          );

      for (final item in items) {
        await _db
            .into(_db.shoppingItems)
            .insert(
              ShoppingItemsCompanion.insert(
                id: _newId('item'),
                listId: newListId,
                name: item.name,
                quantity: Value(item.quantity),
                price: Value(item.price),
                isChecked: const Value(false),
                categoryId: item.categoryId,
                brand: Value(item.brand),
                createdAt: now,
                updatedAt: now,
                syncStatus: Value(SyncStatus.local.name),
              ),
            );
      }
    });

    return newListId;
  }

  @override
  Future<void> finishList(String id) async {
    final list = await _listRowById(id);
    if (list == null) return;

    final now = DateTime.now();
    final itemCount = await _activeItemCount(id);
    if (itemCount == 0) {
      _ensureCanDelete(list);
      await _db.transaction(() async {
        await _softDeleteList(id, now);
      });
      return;
    }

    await (_db.update(
      _db.shoppingLists,
    )..where((table) => table.id.equals(id))).write(
      ShoppingListsCompanion(
        finishedAt: Value(now),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.local.name),
      ),
    );
  }

  @override
  Future<void> deleteList(String id) async {
    final list = await _listRowById(id);
    if (list == null) return;
    _ensureCanDelete(list);

    await _db.transaction(() async {
      await _softDeleteList(id, DateTime.now());
    });
  }

  @override
  Future<void> clearHistory({ListType? type}) async {
    final finishedLists =
        await (_db.select(_db.shoppingLists)..where(
              (table) =>
                  table.deletedAt.isNull() &
                  table.finishedAt.isNotNull() &
                  _ownedByCurrentUser(table) &
                  (type == null
                      ? const Constant(true)
                      : table.type.equals(type.name)),
            ))
            .get();

    if (finishedLists.isEmpty) return;

    final now = DateTime.now();
    await _db.transaction(() async {
      for (final list in finishedLists) {
        await _softDeleteList(list.id, now);
      }
    });
  }

  @override
  Future<void> addItem({
    required String listId,
    required ShoppingItemDraft draft,
  }) async {
    if (draft.name.trim().isEmpty) return;

    final now = DateTime.now();
    await _db.transaction(() async {
      await _insertItem(listId: listId, draft: draft, now: now);
      await _touchList(listId, now);
    });
  }

  @override
  Future<void> updateItem({
    required String id,
    required ShoppingItemDraft draft,
  }) async {
    if (draft.name.trim().isEmpty) return;

    final item = await _itemRowById(id);
    if (item == null) return;

    final now = DateTime.now();
    await _db.transaction(() async {
      await (_db.update(
        _db.shoppingItems,
      )..where((table) => table.id.equals(id))).write(
        ShoppingItemsCompanion(
          name: Value(draft.name.trim()),
          quantity: Value(_emptyToNull(draft.quantity)),
          price: Value(draft.price),
          categoryId: Value(draft.categoryId),
          brand: Value(_emptyToNull(draft.brand)),
          updatedAt: Value(now),
          syncStatus: Value(SyncStatus.local.name),
        ),
      );
      await _touchList(item.listId, now);
    });
  }

  @override
  Future<void> toggleItem({required String id, required bool isChecked}) async {
    final item = await _itemRowById(id);
    if (item == null) return;

    final now = DateTime.now();
    await _db.transaction(() async {
      await (_db.update(
        _db.shoppingItems,
      )..where((table) => table.id.equals(id))).write(
        ShoppingItemsCompanion(
          isChecked: Value(isChecked),
          updatedAt: Value(now),
          syncStatus: Value(SyncStatus.local.name),
        ),
      );
      await _touchList(item.listId, now);
    });
  }

  @override
  Future<void> deleteItem(String id) async {
    final item = await _itemRowById(id);
    if (item == null) return;

    final now = DateTime.now();
    await _db.transaction(() async {
      await (_db.update(
        _db.shoppingItems,
      )..where((table) => table.id.equals(id))).write(
        ShoppingItemsCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
          syncStatus: Value(SyncStatus.deleted.name),
        ),
      );
      await _touchList(item.listId, now);
    });
  }

  Stream<List<ShoppingList>> _watchLists({
    required bool finished,
    ListType? type,
    int? limit,
  }) {
    final query = _db.select(_db.shoppingLists).join([
      leftOuterJoin(
        _db.shoppingItems,
        _db.shoppingItems.listId.equalsExp(_db.shoppingLists.id) &
            _db.shoppingItems.deletedAt.isNull(),
      ),
    ]);

    var predicate =
        _db.shoppingLists.deletedAt.isNull() &
        (finished
            ? _db.shoppingLists.finishedAt.isNotNull()
            : _db.shoppingLists.finishedAt.isNull());

    if (type != null) {
      predicate = predicate & _db.shoppingLists.type.equals(type.name);
    }

    query
      ..where(predicate)
      ..orderBy([
        OrderingTerm.desc(
          finished ? _db.shoppingLists.finishedAt : _db.shoppingLists.updatedAt,
        ),
      ]);

    return query.watch().map((rows) {
      final lists = _mapJoinedRows(rows);
      if (limit != null && lists.length > limit) {
        return lists.take(limit).toList();
      }
      return lists;
    });
  }

  List<ShoppingList> _mapJoinedRows(List<TypedResult> rows) {
    final grouped = <String, _ListItemsAccumulator>{};

    for (final row in rows) {
      final list = row.readTable(_db.shoppingLists);
      final item = row.readTableOrNull(_db.shoppingItems);
      grouped.putIfAbsent(list.id, () => _ListItemsAccumulator(list));
      if (item != null) {
        grouped[list.id]!.items.add(item);
      }
    }

    return grouped.values
        .map((entry) => _mapList(entry.list, entry.items))
        .toList();
  }

  ShoppingList _mapList(ShoppingListRow row, List<ShoppingItemRow> items) {
    final activeItems = items.where((item) => item.deletedAt == null).toList();
    final pendingItems = activeItems
        .where((item) => !item.isChecked)
        .map((item) => item.name)
        .toList();

    return ShoppingList(
      id: row.id,
      type: ListTypeParser.fromDatabase(row.type),
      name: row.name,
      storeName: row.storeName,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      finishedAt: row.finishedAt,
      isShared: row.isShared,
      ownerId: row.ownerId,
      sharedWith: _decodeSharedWith(row.sharedWith),
      syncStatus: SyncStatusParser.fromDatabase(row.syncStatus),
      deletedAt: row.deletedAt,
      totalItems: activeItems.length,
      pendingItems: pendingItems.length,
      total: activeItems.fold<double>(
        0,
        (sum, item) => sum + (item.price ?? 0),
      ),
      pendingItemNames: pendingItems,
      canDelete: _canDelete(row),
    );
  }

  ShoppingItem _mapItem(ShoppingItemRow row) {
    return ShoppingItem(
      id: row.id,
      listId: row.listId,
      name: row.name,
      quantity: row.quantity,
      price: row.price,
      isChecked: row.isChecked,
      categoryId: row.categoryId,
      brand: row.brand,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: SyncStatusParser.fromDatabase(row.syncStatus),
      deletedAt: row.deletedAt,
    );
  }

  CategoryEntity _mapCategory(CategoryRow row) {
    return CategoryEntity(id: row.id, name: row.name, order: row.order);
  }

  Future<void> _insertItem({
    required String listId,
    required ShoppingItemDraft draft,
    required DateTime now,
  }) {
    return _db
        .into(_db.shoppingItems)
        .insert(
          ShoppingItemsCompanion.insert(
            id: _newId('item'),
            listId: listId,
            name: draft.name.trim(),
            quantity: Value(_emptyToNull(draft.quantity)),
            price: Value(draft.price),
            categoryId: draft.categoryId,
            brand: Value(_emptyToNull(draft.brand)),
            createdAt: now,
            updatedAt: now,
            syncStatus: Value(SyncStatus.local.name),
          ),
        );
  }

  Future<void> _touchList(String id, DateTime now) {
    return (_db.update(
      _db.shoppingLists,
    )..where((table) => table.id.equals(id))).write(
      ShoppingListsCompanion(
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.local.name),
      ),
    );
  }

  Future<void> _softDeleteList(String id, DateTime now) async {
    await (_db.update(
      _db.shoppingLists,
    )..where((table) => table.id.equals(id))).write(
      ShoppingListsCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.deleted.name),
      ),
    );

    await (_db.update(
      _db.shoppingItems,
    )..where((table) => table.listId.equals(id))).write(
      ShoppingItemsCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.deleted.name),
      ),
    );
  }

  Future<int> _activeItemCount(String listId) {
    final countExpression = _db.shoppingItems.id.count();
    final query = _db.selectOnly(_db.shoppingItems)
      ..addColumns([countExpression])
      ..where(
        _db.shoppingItems.listId.equals(listId) &
            _db.shoppingItems.deletedAt.isNull(),
      );

    return query.map((row) => row.read(countExpression) ?? 0).getSingle();
  }

  Expression<bool> _ownedByCurrentUser($ShoppingListsTable table) {
    return table.ownerId.equals(_currentUserId) | table.ownerId.isNull();
  }

  bool _canDelete(ShoppingListRow row) {
    return row.ownerId == null || row.ownerId == _currentUserId;
  }

  void _ensureCanDelete(ShoppingListRow row) {
    if (!_canDelete(row)) {
      throw StateError('Solo puedes borrar listas propias.');
    }
  }

  Future<ShoppingListRow?> _listRowById(String id) {
    return (_db.select(
      _db.shoppingLists,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<ShoppingItemRow?> _itemRowById(String id) {
    return (_db.select(
      _db.shoppingItems,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  String _newId(String prefix) {
    final now = DateTime.now().microsecondsSinceEpoch.toRadixString(16);
    final suffix = _random.nextInt(0x7fffffff).toRadixString(16);
    return '$prefix-$now-$suffix';
  }

  String _fallbackName(ListType type, String name) {
    final trimmed = name.trim();
    return trimmed.isEmpty ? type.defaultName : trimmed;
  }

  String? _emptyToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  List<String> _decodeSharedWith(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.whereType<String>().toList();
      }
    } on FormatException {
      return const [];
    }

    return const [];
  }
}

class _ListItemsAccumulator {
  _ListItemsAccumulator(this.list);

  final ShoppingListRow list;
  final List<ShoppingItemRow> items = [];
}
