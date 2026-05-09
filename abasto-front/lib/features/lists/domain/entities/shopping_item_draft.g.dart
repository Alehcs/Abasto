// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_item_draft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShoppingItemDraftImpl _$$ShoppingItemDraftImplFromJson(
  Map<String, dynamic> json,
) => _$ShoppingItemDraftImpl(
  name: json['name'] as String,
  quantity: json['quantity'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  categoryId: (json['categoryId'] as num?)?.toInt() ?? 1,
  brand: json['brand'] as String?,
);

Map<String, dynamic> _$$ShoppingItemDraftImplToJson(
  _$ShoppingItemDraftImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'quantity': instance.quantity,
  'price': instance.price,
  'categoryId': instance.categoryId,
  'brand': instance.brand,
};
