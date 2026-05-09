// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shopping_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShoppingItem _$ShoppingItemFromJson(Map<String, dynamic> json) {
  return _ShoppingItem.fromJson(json);
}

/// @nodoc
mixin _$ShoppingItem {
  String get id => throw _privateConstructorUsedError;
  String get listId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get quantity => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  bool get isChecked => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  SyncStatus get syncStatus => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// Serializes this ShoppingItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShoppingItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShoppingItemCopyWith<ShoppingItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingItemCopyWith<$Res> {
  factory $ShoppingItemCopyWith(
    ShoppingItem value,
    $Res Function(ShoppingItem) then,
  ) = _$ShoppingItemCopyWithImpl<$Res, ShoppingItem>;
  @useResult
  $Res call({
    String id,
    String listId,
    String name,
    String? quantity,
    double? price,
    bool isChecked,
    int categoryId,
    String? brand,
    DateTime createdAt,
    DateTime updatedAt,
    SyncStatus syncStatus,
    DateTime? deletedAt,
  });
}

/// @nodoc
class _$ShoppingItemCopyWithImpl<$Res, $Val extends ShoppingItem>
    implements $ShoppingItemCopyWith<$Res> {
  _$ShoppingItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShoppingItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listId = null,
    Object? name = null,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? isChecked = null,
    Object? categoryId = null,
    Object? brand = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncStatus = null,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            listId: null == listId
                ? _value.listId
                : listId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: freezed == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double?,
            isChecked: null == isChecked
                ? _value.isChecked
                : isChecked // ignore: cast_nullable_to_non_nullable
                      as bool,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            brand: freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            syncStatus: null == syncStatus
                ? _value.syncStatus
                : syncStatus // ignore: cast_nullable_to_non_nullable
                      as SyncStatus,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShoppingItemImplCopyWith<$Res>
    implements $ShoppingItemCopyWith<$Res> {
  factory _$$ShoppingItemImplCopyWith(
    _$ShoppingItemImpl value,
    $Res Function(_$ShoppingItemImpl) then,
  ) = __$$ShoppingItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String listId,
    String name,
    String? quantity,
    double? price,
    bool isChecked,
    int categoryId,
    String? brand,
    DateTime createdAt,
    DateTime updatedAt,
    SyncStatus syncStatus,
    DateTime? deletedAt,
  });
}

/// @nodoc
class __$$ShoppingItemImplCopyWithImpl<$Res>
    extends _$ShoppingItemCopyWithImpl<$Res, _$ShoppingItemImpl>
    implements _$$ShoppingItemImplCopyWith<$Res> {
  __$$ShoppingItemImplCopyWithImpl(
    _$ShoppingItemImpl _value,
    $Res Function(_$ShoppingItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShoppingItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listId = null,
    Object? name = null,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? isChecked = null,
    Object? categoryId = null,
    Object? brand = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncStatus = null,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _$ShoppingItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        listId: null == listId
            ? _value.listId
            : listId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: freezed == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double?,
        isChecked: null == isChecked
            ? _value.isChecked
            : isChecked // ignore: cast_nullable_to_non_nullable
                  as bool,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        brand: freezed == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        syncStatus: null == syncStatus
            ? _value.syncStatus
            : syncStatus // ignore: cast_nullable_to_non_nullable
                  as SyncStatus,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShoppingItemImpl implements _ShoppingItem {
  const _$ShoppingItemImpl({
    required this.id,
    required this.listId,
    required this.name,
    this.quantity,
    this.price,
    this.isChecked = false,
    required this.categoryId,
    this.brand,
    required this.createdAt,
    required this.updatedAt,
    this.syncStatus = SyncStatus.local,
    this.deletedAt,
  });

  factory _$ShoppingItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShoppingItemImplFromJson(json);

  @override
  final String id;
  @override
  final String listId;
  @override
  final String name;
  @override
  final String? quantity;
  @override
  final double? price;
  @override
  @JsonKey()
  final bool isChecked;
  @override
  final int categoryId;
  @override
  final String? brand;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final SyncStatus syncStatus;
  @override
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'ShoppingItem(id: $id, listId: $listId, name: $name, quantity: $quantity, price: $price, isChecked: $isChecked, categoryId: $categoryId, brand: $brand, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.listId, listId) || other.listId == listId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    listId,
    name,
    quantity,
    price,
    isChecked,
    categoryId,
    brand,
    createdAt,
    updatedAt,
    syncStatus,
    deletedAt,
  );

  /// Create a copy of ShoppingItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingItemImplCopyWith<_$ShoppingItemImpl> get copyWith =>
      __$$ShoppingItemImplCopyWithImpl<_$ShoppingItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingItemImplToJson(this);
  }
}

abstract class _ShoppingItem implements ShoppingItem {
  const factory _ShoppingItem({
    required final String id,
    required final String listId,
    required final String name,
    final String? quantity,
    final double? price,
    final bool isChecked,
    required final int categoryId,
    final String? brand,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final SyncStatus syncStatus,
    final DateTime? deletedAt,
  }) = _$ShoppingItemImpl;

  factory _ShoppingItem.fromJson(Map<String, dynamic> json) =
      _$ShoppingItemImpl.fromJson;

  @override
  String get id;
  @override
  String get listId;
  @override
  String get name;
  @override
  String? get quantity;
  @override
  double? get price;
  @override
  bool get isChecked;
  @override
  int get categoryId;
  @override
  String? get brand;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  SyncStatus get syncStatus;
  @override
  DateTime? get deletedAt;

  /// Create a copy of ShoppingItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShoppingItemImplCopyWith<_$ShoppingItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
