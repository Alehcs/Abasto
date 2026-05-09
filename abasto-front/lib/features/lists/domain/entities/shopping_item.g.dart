// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShoppingItemImpl _$$ShoppingItemImplFromJson(Map<String, dynamic> json) =>
    _$ShoppingItemImpl(
      id: json['id'] as String,
      listId: json['listId'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      isChecked: json['isChecked'] as bool? ?? false,
      categoryId: (json['categoryId'] as num).toInt(),
      brand: json['brand'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus:
          $enumDecodeNullable(_$SyncStatusEnumMap, json['syncStatus']) ??
          SyncStatus.local,
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$$ShoppingItemImplToJson(_$ShoppingItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listId': instance.listId,
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
      'isChecked': instance.isChecked,
      'categoryId': instance.categoryId,
      'brand': instance.brand,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

const _$SyncStatusEnumMap = {
  SyncStatus.local: 'local',
  SyncStatus.pending: 'pending',
  SyncStatus.synced: 'synced',
  SyncStatus.conflict: 'conflict',
  SyncStatus.deleted: 'deleted',
};
