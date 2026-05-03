import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class AuthRepository {
  final DioClient _client;

  AuthRepository(this._client);

  Future<String> login(String email, String password) async {
    try {
      final response = await _client.instance.post(
        '/auth/login', // Verifique se o endpoint exato é este
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
}