import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/auth/local_user.dart';
import '../../../../core/constants/list_types.dart';
import '../../../../core/database/database_provider.dart';
import '../../data/repositories/drift_shopping_repository.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/shopping_item.dart';
import '../../domain/entities/shopping_list.dart';
import '../../domain/repositories/shopping_repository.dart';

part 'shopping_providers.g.dart';

@riverpod
ShoppingRepository shoppingRepository(ShoppingRepositoryRef ref) {
  return DriftShoppingRepository(
    ref.watch(appDatabaseProvider),
    currentUserId: ref.watch(currentUserProvider).id,
  );
}

@riverpod
Stream<List<CategoryEntity>> categories(CategoriesRef ref) {
  return ref.watch(shoppingRepositoryProvider).watchCategories();
}

@riverpod
Stream<List<ShoppingList>> activeLists(
  ActiveListsRef ref, {
  ListType? type,
  int? limit,
}) {
  return ref
      .watch(shoppingRepositoryProvider)
      .watchActiveLists(type: type, limit: limit);
}

@riverpod
Stream<List<ShoppingList>> finishedLists(
  FinishedListsRef ref, {
  ListType? type,
}) {
  return ref.watch(shoppingRepositoryProvider).watchFinishedLists(type: type);
}

@riverpod
Stream<ShoppingList?> shoppingList(ShoppingListRef ref, String id) {
  return ref.watch(shoppingRepositoryProvider).watchList(id);
}

@riverpod
Stream<List<ShoppingItem>> listItems(ListItemsRef ref, String listId) {
  return ref.watch(shoppingRepositoryProvider).watchItems(listId);
}
