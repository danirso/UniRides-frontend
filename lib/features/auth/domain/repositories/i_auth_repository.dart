
abstract class IAuthRepository {
  Future<String> login(String email, String password);
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required bool canDrive,
  });
}