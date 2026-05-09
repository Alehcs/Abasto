// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShoppingListImpl _$$ShoppingListImplFromJson(Map<String, dynamic> json) =>
    _$ShoppingListImpl(
      id: json['id'] as String,
      type: $enumDecode(_$ListTypeEnumMap, json['type']),
      name: json['name'] as String,
      storeName: json['storeName'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
      isShared: json['isShared'] as bool? ?? false,
      ownerId: json['ownerId'] as String?,
      sharedWith:
          (json['sharedWith'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      syncStatus:
          $enumDecodeNullable(_$SyncStatusEnumMap, json['syncStatus']) ??
          SyncStatus.local,
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      totalItems: (json['totalItems'] as num?)?.toInt() ?? 0,
      pendingItems: (json['pendingItems'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0,
      pendingItemNames:
          (json['pendingItemNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      canDelete: json['canDelete'] as bool? ?? true,
    );

Map<String, dynamic> _$$ShoppingListImplToJson(_$ShoppingListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ListTypeEnumMap[instance.type]!,
      'name': instance.name,
      'storeName': instance.storeName,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'isShared': instance.isShared,
      'ownerId': instance.ownerId,
      'sharedWith': instance.sharedWith,
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'totalItems': instance.totalItems,
      'pendingItems': instance.pendingItems,
      'total': instance.total,
      'pendingItemNames': instance.pendingItemNames,
      'canDelete': instance.canDelete,
    };

const _$ListTypeEnumMap = {
  ListType.supermercado: 'supermercado',
  ListType.feria: 'feria',
};

const _$SyncStatusEnumMap = {
  SyncStatus.local: 'local',
  SyncStatus.pending: 'pending',
  SyncStatus.synced: 'synced',
  SyncStatus.conflict: 'conflict',
  SyncStatus.deleted: 'deleted',
};
