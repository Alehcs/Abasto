// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocalUser _$LocalUserFromJson(Map<String, dynamic> json) {
  return _LocalUser.fromJson(json);
}

/// @nodoc
mixin _$LocalUser {
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;

  /// Serializes this LocalUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocalUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalUserCopyWith<LocalUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalUserCopyWith<$Res> {
  factory $LocalUserCopyWith(LocalUser value, $Res Function(LocalUser) then) =
      _$LocalUserCopyWithImpl<$Res, LocalUser>;
  @useResult
  $Res call({String id, String displayName, bool isAnonymous});
}

/// @nodoc
class _$LocalUserCopyWithImpl<$Res, $Val extends LocalUser>
    implements $LocalUserCopyWith<$Res> {
  _$LocalUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? isAnonymous = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            isAnonymous: null == isAnonymous
                ? _value.isAnonymous
                : isAnonymous // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocalUserImplCopyWith<$Res>
    implements $LocalUserCopyWith<$Res> {
  factory _$$LocalUserImplCopyWith(
    _$LocalUserImpl value,
    $Res Function(_$LocalUserImpl) then,
  ) = __$$LocalUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String displayName, bool isAnonymous});
}

/// @nodoc
class __$$LocalUserImplCopyWithImpl<$Res>
    extends _$LocalUserCopyWithImpl<$Res, _$LocalUserImpl>
    implements _$$LocalUserImplCopyWith<$Res> {
  __$$LocalUserImplCopyWithImpl(
    _$LocalUserImpl _value,
    $Res Function(_$LocalUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocalUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? isAnonymous = null,
  }) {
    return _then(
      _$LocalUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        isAnonymous: null == isAnonymous
            ? _value.isAnonymous
            : isAnonymous // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalUserImpl implements _LocalUser {
  const _$LocalUserImpl({
    required this.id,
    required this.displayName,
    this.isAnonymous = true,
  });

  factory _$LocalUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalUserImplFromJson(json);

  @override
  final String id;
  @override
  final String displayName;
  @override
  @JsonKey()
  final bool isAnonymous;

  @override
  String toString() {
    return 'LocalUser(id: $id, displayName: $displayName, isAnonymous: $isAnonymous)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, displayName, isAnonymous);

  /// Create a copy of LocalUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalUserImplCopyWith<_$LocalUserImpl> get copyWith =>
      __$$LocalUserImplCopyWithImpl<_$LocalUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalUserImplToJson(this);
  }
}

abstract class _LocalUser implements LocalUser {
  const factory _LocalUser({
    required final String id,
    required final String displayName,
    final bool isAnonymous,
  }) = _$LocalUserImpl;

  factory _LocalUser.fromJson(Map<String, dynamic> json) =
      _$LocalUserImpl.fromJson;

  @override
  String get id;
  @override
  String get displayName;
  @override
  bool get isAnonymous;

  /// Create a copy of LocalUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalUserImplCopyWith<_$LocalUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
