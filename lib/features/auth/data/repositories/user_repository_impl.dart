import 'package:tcc_caronas_frontend/core/network/dio_client.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_user_repository.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements IUserRepository {
  final DioClient _client;

  UserRepositoryImpl(this._client);

  @override
  Future<UserEntity> getMe() async {
    try {
      final response = await _client.instance.get('/users/me');
      return UserModel.fromJson(response.data);
    } catch (e) {
   
      throw Exception('Erro ao buscar dados do usuário');
    }
  }

  @override
  Future<UserEntity> updateMe({
    String? name,
    String? email,
    String? password,
    bool? canDrive,
  }) async {
    try {
      final data = {
        'name': name,
        'email': email,
        'password': password,
        'can_drive': canDrive,
      }..removeWhere((key, value) => value == null);

      final response = await _client.instance.patch('/users/me', data: data);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Erro ao atualizar perfil');
    }
  }

  @override
  Future<void> deleteMe() async {
    try {
      await _client.instance.delete('/users/me');
    } catch (e) {
      throw Exception('Erro ao deletar perfil');
    }
  }
}