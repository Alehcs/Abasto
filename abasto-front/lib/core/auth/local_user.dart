import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_user.freezed.dart';
part 'local_user.g.dart';

@freezed
class LocalUser with _$LocalUser {
  const factory LocalUser({
    required String id,
    required String displayName,
    @Default(true) bool isAnonymous,
  }) = _LocalUser;

  factory LocalUser.fromJson(Map<String, dynamic> json) =>
      _$LocalUserFromJson(json);
}

@Riverpod(keepAlive: true)
LocalUser currentUser(CurrentUserRef ref) {
  return const LocalUser(id: 'local-user', displayName: 'Alejandro');
}
