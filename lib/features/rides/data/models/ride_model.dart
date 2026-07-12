import '../../domain/entities/ride_entity.dart';

class RideModel extends RideEntity {
  const RideModel({
    required super.id,
    required super.driverId,
    required super.driverName,
    super.driverRatingAvg,
    super.driverRatingCount,
    required super.vehicleId,
    required super.departureTime,
    required super.status,
    required super.availableSeats,
    required super.maxDetourMeters,
    required super.estimatedDurationMins,
    required super.distanceKm,
    required super.routePolyline,
    required super.originAddress,
    required super.destinationAddress,
    required super.createdAt,
    required super.updatedAt,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'].toString(),
      driverId: json['driver_id'].toString(),
      driverName: json['driver']['name'] ?? '',
      driverRatingAvg: (json['driver']['rating_avg'] as num?)?.toDouble() ?? 0.0,
      driverRatingCount: json['driver']['rating_count'] ?? 0,
      vehicleId: json['vehicle_id'].toString(),
      departureTime: DateTime.parse(json['departure_time']),
      status: json['status'],
      availableSeats: json['available_seats'],
      maxDetourMeters: json['max_detour_meters'],
      estimatedDurationMins: json['estimated_duration_mins'],
      distanceKm: (json['distance_km'] as num).toDouble(),
      routePolyline: json['route_polyline'],
      originAddress: json['origin_address'],
      destinationAddress: json['destination_address'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle_id': vehicleId,
      'departure_time': departureTime.toUtc().toIso8601String(),
      'available_seats': availableSeats,
      'max_detour_meters': maxDetourMeters,
      'origin_address': originAddress,
      'destination_address': destinationAddress,
    };
  }
}