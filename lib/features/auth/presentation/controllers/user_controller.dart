import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_user_repository.dart';

final dioClientProvider = Provider((ref) => DioClient());

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  return UserRepositoryImpl(ref.watch(dioClientProvider));
});

final userControllerProvider = NotifierProvider<UserController, AsyncValue<UserEntity?>>(UserController.new);


class UserController extends Notifier<AsyncValue<UserEntity?>> {
  late IUserRepository _repository;

  @override
  AsyncValue<UserEntity?> build() {
    _repository = ref.watch(userRepositoryProvider);
    return const AsyncValue.data(null);
  }

  Future<void> loadUserProfile() async {
    state = const AsyncValue.loading();
    try {
      final user = await _repository.getMe();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void clear() {
    state = const AsyncValue.data(null);
  }
}