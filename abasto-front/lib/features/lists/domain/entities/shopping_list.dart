import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/list_types.dart';
import '../../../../core/services/sync_status.dart';

part 'shopping_list.freezed.dart';
part 'shopping_list.g.dart';

@freezed
class ShoppingList with _$ShoppingList {
  const factory ShoppingList({
    required String id,
    required ListType type,
    required String name,
    String? storeName,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? finishedAt,
    @Default(false) bool isShared,
    String? ownerId,
    @Default(<String>[]) List<String> sharedWith,
    @Default(SyncStatus.local) SyncStatus syncStatus,
    DateTime? deletedAt,
    @Default(0) int totalItems,
    @Default(0) int pendingItems,
    @Default(0) double total,
    @Default(<String>[]) List<String> pendingItemNames,
    @Default(true) bool canDelete,
  }) = _ShoppingList;

  factory ShoppingList.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListFromJson(json);
}
