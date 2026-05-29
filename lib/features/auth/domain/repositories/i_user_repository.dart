import '../entities/user_entity.dart';

abstract class IUserRepository {
  Future<UserEntity> getMe();
  Future<UserEntity> updateMe({
    String? name,
    String? email,
    String? password,
    bool? canDrive,
  });
  Future<void> deleteMe();
}