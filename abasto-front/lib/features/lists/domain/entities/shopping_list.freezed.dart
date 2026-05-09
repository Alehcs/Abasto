// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shopping_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShoppingList _$ShoppingListFromJson(Map<String, dynamic> json) {
  return _ShoppingList.fromJson(json);
}

/// @nodoc
mixin _$ShoppingList {
  String get id => throw _privateConstructorUsedError;
  ListType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get storeName => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get finishedAt => throw _privateConstructorUsedError;
  bool get isShared => throw _privateConstructorUsedError;
  String? get ownerId => throw _privateConstructorUsedError;
  List<String> get sharedWith => throw _privateConstructorUsedError;
  SyncStatus get syncStatus => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;
  int get pendingItems => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  List<String> get pendingItemNames => throw _privateConstructorUsedError;
  bool get canDelete => throw _privateConstructorUsedError;

  /// Serializes this ShoppingList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShoppingList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShoppingListCopyWith<ShoppingList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingListCopyWith<$Res> {
  factory $ShoppingListCopyWith(
    ShoppingList value,
    $Res Function(ShoppingList) then,
  ) = _$ShoppingListCopyWithImpl<$Res, ShoppingList>;
  @useResult
  $Res call({
    String id,
    ListType type,
    String name,
    String? storeName,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? finishedAt,
    bool isShared,
    String? ownerId,
    List<String> sharedWith,
    SyncStatus syncStatus,
    DateTime? deletedAt,
    int totalItems,
    int pendingItems,
    double total,
    List<String> pendingItemNames,
    bool canDelete,
  });
}

/// @nodoc
class _$ShoppingListCopyWithImpl<$Res, $Val extends ShoppingList>
    implements $ShoppingListCopyWith<$Res> {
  _$ShoppingListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShoppingList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? storeName = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? finishedAt = freezed,
    Object? isShared = null,
    Object? ownerId = freezed,
    Object? sharedWith = null,
    Object? syncStatus = null,
    Object? deletedAt = freezed,
    Object? totalItems = null,
    Object? pendingItems = null,
    Object? total = null,
    Object? pendingItemNames = null,
    Object? canDelete = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ListType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            storeName: freezed == storeName
                ? _value.storeName
                : storeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            finishedAt: freezed == finishedAt
                ? _value.finishedAt
                : finishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isShared: null == isShared
                ? _value.isShared
                : isShared // ignore: cast_nullable_to_non_nullable
                      as bool,
            ownerId: freezed == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            sharedWith: null == sharedWith
                ? _value.sharedWith
                : sharedWith // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            syncStatus: null == syncStatus
                ? _value.syncStatus
                : syncStatus // ignore: cast_nullable_to_non_nullable
                      as SyncStatus,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            totalItems: null == totalItems
                ? _value.totalItems
                : totalItems // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingItems: null == pendingItems
                ? _value.pendingItems
                : pendingItems // ignore: cast_nullable_to_non_nullable
                      as int,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            pendingItemNames: null == pendingItemNames
                ? _value.pendingItemNames
                : pendingItemNames // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            canDelete: null == canDelete
                ? _value.canDelete
                : canDelete // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShoppingListImplCopyWith<$Res>
    implements $ShoppingListCopyWith<$Res> {
  factory _$$ShoppingListImplCopyWith(
    _$ShoppingListImpl value,
    $Res Function(_$ShoppingListImpl) then,
  ) = __$$ShoppingListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    ListType type,
    String name,
    String? storeName,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? finishedAt,
    bool isShared,
    String? ownerId,
    List<String> sharedWith,
    SyncStatus syncStatus,
    DateTime? deletedAt,
    int totalItems,
    int pendingItems,
    double total,
    List<String> pendingItemNames,
    bool canDelete,
  });
}

/// @nodoc
class __$$ShoppingListImplCopyWithImpl<$Res>
    extends _$ShoppingListCopyWithImpl<$Res, _$ShoppingListImpl>
    implements _$$ShoppingListImplCopyWith<$Res> {
  __$$ShoppingListImplCopyWithImpl(
    _$ShoppingListImpl _value,
    $Res Function(_$ShoppingListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShoppingList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? storeName = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? finishedAt = freezed,
    Object? isShared = null,
    Object? ownerId = freezed,
    Object? sharedWith = null,
    Object? syncStatus = null,
    Object? deletedAt = freezed,
    Object? totalItems = null,
    Object? pendingItems = null,
    Object? total = null,
    Object? pendingItemNames = null,
    Object? canDelete = null,
  }) {
    return _then(
      _$ShoppingListImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ListType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        storeName: freezed == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        finishedAt: freezed == finishedAt
            ? _value.finishedAt
            : finishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isShared: null == isShared
            ? _value.isShared
            : isShared // ignore: cast_nullable_to_non_nullable
                  as bool,
        ownerId: freezed == ownerId
            ? _value.ownerId
            : ownerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        sharedWith: null == sharedWith
            ? _value._sharedWith
            : sharedWith // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        syncStatus: null == syncStatus
            ? _value.syncStatus
            : syncStatus // ignore: cast_nullable_to_non_nullable
                  as SyncStatus,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        totalItems: null == totalItems
            ? _value.totalItems
            : totalItems // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingItems: null == pendingItems
            ? _value.pendingItems
            : pendingItems // ignore: cast_nullable_to_non_nullable
                  as int,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        pendingItemNames: null == pendingItemNames
            ? _value._pendingItemNames
            : pendingItemNames // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        canDelete: null == canDelete
            ? _value.canDelete
            : canDelete // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShoppingListImpl implements _ShoppingList {
  const _$ShoppingListImpl({
    required this.id,
    required this.type,
    required this.name,
    this.storeName,
    required this.createdAt,
    required this.updatedAt,
    this.finishedAt,
    this.isShared = false,
    this.ownerId,
    final List<String> sharedWith = const <String>[],
    this.syncStatus = SyncStatus.local,
    this.deletedAt,
    this.totalItems = 0,
    this.pendingItems = 0,
    this.total = 0,
    final List<String> pendingItemNames = const <String>[],
    this.canDelete = true,
  }) : _sharedWith = sharedWith,
       _pendingItemNames = pendingItemNames;

  factory _$ShoppingListImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShoppingListImplFromJson(json);

  @override
  final String id;
  @override
  final ListType type;
  @override
  final String name;
  @override
  final String? storeName;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? finishedAt;
  @override
  @JsonKey()
  final bool isShared;
  @override
  final String? ownerId;
  final List<String> _sharedWith;
  @override
  @JsonKey()
  List<String> get sharedWith {
    if (_sharedWith is EqualUnmodifiableListView) return _sharedWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWith);
  }

  @override
  @JsonKey()
  final SyncStatus syncStatus;
  @override
  final DateTime? deletedAt;
  @override
  @JsonKey()
  final int totalItems;
  @override
  @JsonKey()
  final int pendingItems;
  @override
  @JsonKey()
  final double total;
  final List<String> _pendingItemNames;
  @override
  @JsonKey()
  List<String> get pendingItemNames {
    if (_pendingItemNames is EqualUnmodifiableListView)
      return _pendingItemNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingItemNames);
  }

  @override
  @JsonKey()
  final bool canDelete;

  @override
  String toString() {
    return 'ShoppingList(id: $id, type: $type, name: $name, storeName: $storeName, createdAt: $createdAt, updatedAt: $updatedAt, finishedAt: $finishedAt, isShared: $isShared, ownerId: $ownerId, sharedWith: $sharedWith, syncStatus: $syncStatus, deletedAt: $deletedAt, totalItems: $totalItems, pendingItems: $pendingItems, total: $total, pendingItemNames: $pendingItemNames, canDelete: $canDelete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.finishedAt, finishedAt) ||
                other.finishedAt == finishedAt) &&
            (identical(other.isShared, isShared) ||
                other.isShared == isShared) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality().equals(
              other._sharedWith,
              _sharedWith,
            ) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.pendingItems, pendingItems) ||
                other.pendingItems == pendingItems) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(
              other._pendingItemNames,
              _pendingItemNames,
            ) &&
            (identical(other.canDelete, canDelete) ||
                other.canDelete == canDelete));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    name,
    storeName,
    createdAt,
    updatedAt,
    finishedAt,
    isShared,
    ownerId,
    const DeepCollectionEquality().hash(_sharedWith),
    syncStatus,
    deletedAt,
    totalItems,
    pendingItems,
    total,
    const DeepCollectionEquality().hash(_pendingItemNames),
    canDelete,
  );

  /// Create a copy of ShoppingList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingListImplCopyWith<_$ShoppingListImpl> get copyWith =>
      __$$ShoppingListImplCopyWithImpl<_$ShoppingListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingListImplToJson(this);
  }
}

abstract class _ShoppingList implements ShoppingList {
  const factory _ShoppingList({
    required final String id,
    required final ListType type,
    required final String name,
    final String? storeName,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final DateTime? finishedAt,
    final bool isShared,
    final String? ownerId,
    final List<String> sharedWith,
    final SyncStatus syncStatus,
    final DateTime? deletedAt,
    final int totalItems,
    final int pendingItems,
    final double total,
    final List<String> pendingItemNames,
    final bool canDelete,
  }) = _$ShoppingListImpl;

  factory _ShoppingList.fromJson(Map<String, dynamic> json) =
      _$ShoppingListImpl.fromJson;

  @override
  String get id;
  @override
  ListType get type;
  @override
  String get name;
  @override
  String? get storeName;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get finishedAt;
  @override
  bool get isShared;
  @override
  String? get ownerId;
  @override
  List<String> get sharedWith;
  @override
  SyncStatus get syncStatus;
  @override
  DateTime? get deletedAt;
  @override
  int get totalItems;
  @override
  int get pendingItems;
  @override
  double get total;
  @override
  List<String> get pendingItemNames;
  @override
  bool get canDelete;

  /// Create a copy of ShoppingList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShoppingListImplCopyWith<_$ShoppingListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
