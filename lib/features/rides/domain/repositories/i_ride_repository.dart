import '../entities/ride_entity.dart';
import '../entities/ride_request_entity.dart';

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

  Future<RideEntity> updateRide({
    required String rideId,
    String? vehicleId,
    int? availableSeats,
    int? maxDetourMeters,
    DateTime? departureTime,
  });

  Future<RideEntity> startRide(String rideId);
  Future<RideEntity> completeRide(String rideId);
  Future<RideEntity> cancelRide(String rideId);

  Future<List<RideRequestWithPassengerEntity>> getRideRequests(String rideId);
  Future<void> acceptRequest(String rideId, String requestId);
  Future<void> rejectRequest(String rideId, String requestId);

  Future<List<RideRequestWithRideEntity>> getMyRequests();
  Future<void> cancelRequest(String rideId, String requestId);

  Future <List<RideEntity>> searchRides({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng
  });

  Future<void> requestSeat({
    required String rideId,
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
    required String originAddress,
    required String destinationAddress,
  });
}