// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shopping_item_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShoppingItemDraft _$ShoppingItemDraftFromJson(Map<String, dynamic> json) {
  return _ShoppingItemDraft.fromJson(json);
}

/// @nodoc
mixin _$ShoppingItemDraft {
  String get name => throw _privateConstructorUsedError;
  String? get quantity => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;

  /// Serializes this ShoppingItemDraft to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShoppingItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShoppingItemDraftCopyWith<ShoppingItemDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingItemDraftCopyWith<$Res> {
  factory $ShoppingItemDraftCopyWith(
    ShoppingItemDraft value,
    $Res Function(ShoppingItemDraft) then,
  ) = _$ShoppingItemDraftCopyWithImpl<$Res, ShoppingItemDraft>;
  @useResult
  $Res call({
    String name,
    String? quantity,
    double? price,
    int categoryId,
    String? brand,
  });
}

/// @nodoc
class _$ShoppingItemDraftCopyWithImpl<$Res, $Val extends ShoppingItemDraft>
    implements $ShoppingItemDraftCopyWith<$Res> {
  _$ShoppingItemDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShoppingItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? categoryId = null,
    Object? brand = freezed,
  }) {
    return _then(
      _value.copyWith(
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
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            brand: freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShoppingItemDraftImplCopyWith<$Res>
    implements $ShoppingItemDraftCopyWith<$Res> {
  factory _$$ShoppingItemDraftImplCopyWith(
    _$ShoppingItemDraftImpl value,
    $Res Function(_$ShoppingItemDraftImpl) then,
  ) = __$$ShoppingItemDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String? quantity,
    double? price,
    int categoryId,
    String? brand,
  });
}

/// @nodoc
class __$$ShoppingItemDraftImplCopyWithImpl<$Res>
    extends _$ShoppingItemDraftCopyWithImpl<$Res, _$ShoppingItemDraftImpl>
    implements _$$ShoppingItemDraftImplCopyWith<$Res> {
  __$$ShoppingItemDraftImplCopyWithImpl(
    _$ShoppingItemDraftImpl _value,
    $Res Function(_$ShoppingItemDraftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShoppingItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? categoryId = null,
    Object? brand = freezed,
  }) {
    return _then(
      _$ShoppingItemDraftImpl(
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
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        brand: freezed == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShoppingItemDraftImpl implements _ShoppingItemDraft {
  const _$ShoppingItemDraftImpl({
    required this.name,
    this.quantity,
    this.price,
    this.categoryId = 1,
    this.brand,
  });

  factory _$ShoppingItemDraftImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShoppingItemDraftImplFromJson(json);

  @override
  final String name;
  @override
  final String? quantity;
  @override
  final double? price;
  @override
  @JsonKey()
  final int categoryId;
  @override
  final String? brand;

  @override
  String toString() {
    return 'ShoppingItemDraft(name: $name, quantity: $quantity, price: $price, categoryId: $categoryId, brand: $brand)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingItemDraftImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.brand, brand) || other.brand == brand));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, quantity, price, categoryId, brand);

  /// Create a copy of ShoppingItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingItemDraftImplCopyWith<_$ShoppingItemDraftImpl> get copyWith =>
      __$$ShoppingItemDraftImplCopyWithImpl<_$ShoppingItemDraftImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingItemDraftImplToJson(this);
  }
}

abstract class _ShoppingItemDraft implements ShoppingItemDraft {
  const factory _ShoppingItemDraft({
    required final String name,
    final String? quantity,
    final double? price,
    final int categoryId,
    final String? brand,
  }) = _$ShoppingItemDraftImpl;

  factory _ShoppingItemDraft.fromJson(Map<String, dynamic> json) =
      _$ShoppingItemDraftImpl.fromJson;

  @override
  String get name;
  @override
  String? get quantity;
  @override
  double? get price;
  @override
  int get categoryId;
  @override
  String? get brand;

  /// Create a copy of ShoppingItemDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShoppingItemDraftImplCopyWith<_$ShoppingItemDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
