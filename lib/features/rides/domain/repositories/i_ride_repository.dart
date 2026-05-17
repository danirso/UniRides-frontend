import '../entities/ride_entity.dart';

abstract class IRideRepository {
  Future<RideEntity> createRide({
    required String vehicleId,
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
    required String originAddress,
    required String destinationAddress,
    required DateTime departureTime,
    required int availableSeats,
    required int maxDetourMeters,
  });

  Future<List<RideEntity>> getMyRides();
}