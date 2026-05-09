import 'package:dio/dio.dart';
import '../../domain/repositories/i_auth_repository.dart';
import 'package:tcc_caronas_frontend/core/network/dio_client.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final DioClient _client;

  AuthRepositoryImpl(this._client);

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await _client.instance.post(
        '/auth/login',
        data: FormData.fromMap({
          'username': email,
          'password': password,
        }),
      );
      return response.data['access_token'];
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Falha na autenticação');
    }
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required bool canDrive,
  }) async {
    try {
      await _client.instance.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'can_drive': canDrive,
        },
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'Falha no cadastro');
    }
  }
}