// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalUserImpl _$$LocalUserImplFromJson(Map<String, dynamic> json) =>
    _$LocalUserImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      isAnonymous: json['isAnonymous'] as bool? ?? true,
    );

Map<String, dynamic> _$$LocalUserImplToJson(_$LocalUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'isAnonymous': instance.isAnonymous,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'4353494e4edefd3ead18c727e77857db88305f9f';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = Provider<LocalUser>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = ProviderRef<LocalUser>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
