class RideEntity {
  final String id;
  final String driverId;
  final String driverName;
  final String vehicleId;
  final DateTime departureTime;
  final String status;
  final int availableSeats;
  final int maxDetourMeters;
  final int estimatedDurationMins;
  final double distanceKm;
  final String routePolyline;
  final String originAddress;
  final String destinationAddress;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RideEntity({
    required this.id,
    required this.driverId,
    required this.driverName,
    required this.vehicleId,
    required this.departureTime,
    required this.status,
    required this.availableSeats,
    required this.maxDetourMeters,
    required this.estimatedDurationMins,
    required this.distanceKm,
    required this.routePolyline,
    required this.originAddress,
    required this.destinationAddress,
    required this.createdAt,
    required this.updatedAt,
  });
}