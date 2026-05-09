import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_item_draft.freezed.dart';
part 'shopping_item_draft.g.dart';

@freezed
class ShoppingItemDraft with _$ShoppingItemDraft {
  const factory ShoppingItemDraft({
    required String name,
    String? quantity,
    double? price,
    @Default(1) int categoryId,
    String? brand,
  }) = _ShoppingItemDraft;

  factory ShoppingItemDraft.fromJson(Map<String, dynamic> json) =>
      _$ShoppingItemDraftFromJson(json);
}
