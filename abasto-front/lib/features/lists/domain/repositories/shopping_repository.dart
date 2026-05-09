import '../../../../core/constants/list_types.dart';
import '../entities/category_entity.dart';
import '../entities/shopping_item.dart';
import '../entities/shopping_item_draft.dart';
import '../entities/shopping_list.dart';

abstract class ShoppingRepository {
  Stream<List<CategoryEntity>> watchCategories();

  Stream<List<ShoppingList>> watchActiveLists({ListType? type, int? limit});

  Stream<List<ShoppingList>> watchFinishedLists({ListType? type});

  Stream<ShoppingList?> watchList(String id);

  Stream<List<ShoppingItem>> watchItems(String listId);

  Future<ShoppingList> createList({
    required ListType type,
    required String name,
    String? storeName,
    List<ShoppingItemDraft> items,
  });

  Future<void> updateList({
    required String id,
    required String name,
    String? storeName,
  });

  Future<String> duplicateList(String id);

  Future<void> finishList(String id);

  Future<void> deleteList(String id);

  Future<void> clearHistory({ListType? type});

  Future<void> addItem({
    required String listId,
    required ShoppingItemDraft draft,
  });

  Future<void> updateItem({
    required String id,
    required ShoppingItemDraft draft,
  });

  Future<void> toggleItem({required String id, required bool isChecked});

  Future<void> deleteItem(String id);
}
