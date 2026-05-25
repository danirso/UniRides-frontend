import '../entities/vehicle_entity.dart';

abstract class IVehicleRepository {
  Future<List<VehicleEntity>> getMyVehicles();
  Future<void> registerVehicle({
    required String plate,
    required String brand,
    required String model,
    required String color,
    required int capacity,
  });
  Future<void> deleteVehicle(String vehicleId);
  Future<void> updateVehicle({
    required String vehicleId,
    String? brand,
    String? model,
    String? color,
    String? plate,
    int? capacity,
  });
}