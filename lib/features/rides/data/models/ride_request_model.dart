import '../../domain/entities/ride_request_entity.dart';

class PassengerSnippetModel extends PassengerSnippetEntity {
  const PassengerSnippetModel({
    required super.id,
    required super.name,
    super.ratingAvg,
    super.ratingCount,
  });

  factory PassengerSnippetModel.fromJson(Map<String, dynamic> json) {
    return PassengerSnippetModel(
      id: json['id'].toString(),
      name: json['name'],
      ratingAvg: (json['rating_avg'] as num?)?.toDouble() ?? 0.0,
      ratingCount: json['rating_count'] ?? 0,
    );
  }
}

class RideSnippetModel extends RideSnippetEntity {
  const RideSnippetModel({
    required super.id,
    required super.originAddress,
    required super.destinationAddress,
    required super.departureTime,
    required super.status,
  });

  factory RideSnippetModel.fromJson(Map<String, dynamic> json) {
    return RideSnippetModel(
      id: json['id'].toString(),
      originAddress: json['origin_address'],
      destinationAddress: json['destination_address'],
      departureTime: DateTime.parse(json['departure_time']),
      status: json['status'],
    );
  }
}

class RideRequestWithPassengerModel extends RideRequestWithPassengerEntity {
  const RideRequestWithPassengerModel({
    required super.id,
    required super.rideId,
    required super.passengerId,
    required super.status,
    required super.createdAt,
    required super.passenger,
    required super.originAddress,
    required super.destinationAddress
  });

  factory RideRequestWithPassengerModel.fromJson(Map<String, dynamic> json) {
    return RideRequestWithPassengerModel(
      id: json['id'].toString(),
      rideId: json['ride_id'].toString(),
      passengerId: json['passenger_id'].toString(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      passenger: PassengerSnippetModel.fromJson(json['passenger']),
      originAddress: json['origin_address'],
      destinationAddress: json['destination_address'],
    );
  }
}

class RideRequestWithRideModel extends RideRequestWithRideEntity {
  const RideRequestWithRideModel({
    required super.id,
    required super.rideId,
    required super.passengerId,
    required super.status,
    required super.createdAt,
    required super.ride,
  });

  factory RideRequestWithRideModel.fromJson(Map<String, dynamic> json) {
    return RideRequestWithRideModel(
      id: json['id'].toString(),
      rideId: json['ride_id'].toString(),
      passengerId: json['passenger_id'].toString(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      ride: RideSnippetModel.fromJson(json['ride']),
    );
  }
}