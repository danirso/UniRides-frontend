import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/repositories/vehicle_repository_impl.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../../domain/repositories/i_vehicle_repository.dart';

final dioClientProvider = Provider((ref) => DioClient());

final vehicleRepositoryProvider = Provider<IVehicleRepository>((ref) {
  return VehicleRepositoryImpl(ref.watch(dioClientProvider));
});

final vehicleControllerProvider = 
    NotifierProvider<VehicleController, AsyncValue<List<VehicleEntity>>>(VehicleController.new);


class VehicleController extends Notifier<AsyncValue<List<VehicleEntity>>> {
  late IVehicleRepository _repository;

  @override
  AsyncValue<List<VehicleEntity>> build() {
    _repository = ref.watch(vehicleRepositoryProvider);
    
    return const AsyncValue.loading();
  }

  Future<void> fetchVehicles() async {
    state = const AsyncValue.loading();
    try {
      final vehicles = await _repository.getMyVehicles();
      state = AsyncValue.data(vehicles);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> addVehicle({
    required String plate, 
    required String brand, 
    required String model, 
    required String color,
    required int capacity,
  }) async {
    try {
      await _repository.registerVehicle(
        plate: plate, 
        brand: brand,
        model: model, 
        color: color,
        capacity: capacity,
      );
      await fetchVehicles();
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deleteVehicle(String vehicleId) async {
  try {
    await _repository.deleteVehicle(vehicleId);
    await fetchVehicles();
    return true;
  } catch (e, st) {
    state = AsyncValue.error(e, st);
    return false;
  }
}

Future<bool> updateVehicle({
  required String vehicleId,
  String? brand,
  String? model,
  String? color,
  String? plate,
  int? capacity,
}) async {
  try {
    await _repository.updateVehicle(
      vehicleId: vehicleId,
      brand: brand,
      model: model,
      color: color,
      plate: plate,
      capacity: capacity,
    );
    await fetchVehicles();
    return true;
  } catch (e, st) {
    state = AsyncValue.error(e, st);
    return false;
  }
}
}