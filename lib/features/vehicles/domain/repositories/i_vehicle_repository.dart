import '../entities/vehicle_entity.dart';

abstract class IVehicleRepository {
  Future<List<VehicleEntity>> getMyVehicles();
  Future<void> registerVehicle({
    required String plate,
    required String model,
    required String color,
  });
}