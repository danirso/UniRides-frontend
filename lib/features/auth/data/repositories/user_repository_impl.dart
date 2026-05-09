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
}