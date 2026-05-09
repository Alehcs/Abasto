import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/services/sync_status.dart';

part 'shopping_item.freezed.dart';
part 'shopping_item.g.dart';

@freezed
class ShoppingItem with _$ShoppingItem {
  const factory ShoppingItem({
    required String id,
    required String listId,
    required String name,
    String? quantity,
    double? price,
    @Default(false) bool isChecked,
    required int categoryId,
    String? brand,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(SyncStatus.local) SyncStatus syncStatus,
    DateTime? deletedAt,
  }) = _ShoppingItem;

  factory ShoppingItem.fromJson(Map<String, dynamic> json) =>
      _$ShoppingItemFromJson(json);
}
