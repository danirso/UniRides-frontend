import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/network/dio_client.dart';
import '../data/auth_repository.dart';

// Provedores de injeção de dependência
final dioClientProvider = Provider((ref) => DioClient());

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(ref.watch(dioClientProvider));
});

// Provedor do controlador
final authControllerProvider = NotifierProvider<AuthController, AsyncValue<void>>(AuthController.new);


class AuthController extends Notifier<AsyncValue<void>> {
  late AuthRepository _repository;
  final _storage = const FlutterSecureStorage();

  @override
  AsyncValue<void> build() {
    _repository = ref.watch(authRepositoryProvider);
    return const AsyncValue.data(null);
  }

  Future<bool> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final token = await _repository.login(email, password);
      
      await _storage.write(key: 'access_token', value: token);
      debugPrint('Token salvo com sucesso no dispositivo.');
      
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> register(String name, String email, String password, bool canDrive) async {
    state = const AsyncValue.loading();
    try {
      await _repository.register(name, email, password, canDrive);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}