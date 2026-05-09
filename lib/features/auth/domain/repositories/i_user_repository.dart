import '../entities/user_entity.dart';

abstract class IUserRepository {
  Future<UserEntity> getMe();
}