import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tcc_caronas_frontend/features/auth/domain/errors/auth_failures.dart';
import 'package:tcc_caronas_frontend/features/auth/presentation/controllers/user_controller.dart';
import 'package:tcc_caronas_frontend/features/vehicles/presentation/controllers/vehicle_controller.dart';
import 'package:tcc_caronas_frontend/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:tcc_caronas_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tcc_caronas_frontend/core/network/dio_provider.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(dioClientProvider));
});

final authControllerProvider = NotifierProvider<AuthController, AsyncValue<void>>(AuthController.new);

class AuthController extends Notifier<AsyncValue<void>> {
  late IAuthRepository _repository;
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
      state = const AsyncValue.data(null);
      return true;
    } on AuthFailure catch(e, st) {
      state = AsyncValue.error(e, st);
      return false;
    } catch (e, st) {
      debugPrint("Erro não mapeado: $e");
      state = AsyncValue.error(ServerFailure(), st);
      return false;
    }
  }

  Future<bool> register(String name, String email, String password, bool canDrive) async {
    state = const AsyncValue.loading();
    try {
      await _repository.register(
        name: name,
        email: email,
        password: password,
        canDrive: canDrive,
      );
      state = const AsyncValue.data(null);
      return true;
    } on AuthFailure catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    } catch (e, st) {
      state = AsyncValue.error(ServerFailure(), st);
      return false;
    }
  }

Future<void> logout() async {
  state = const AsyncValue.loading();
  try {
    await _storage.delete(key: 'access_token');
    ref.read(userControllerProvider.notifier).clear();
    ref.invalidate(vehicleControllerProvider);
    
    state = const AsyncValue.data(null);
  } catch (e, st) {
    state = AsyncValue.error(e, st);
  }
}
}