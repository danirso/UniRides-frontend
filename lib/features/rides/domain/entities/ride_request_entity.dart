class PassengerSnippetEntity {
  final String id;
  final String name;
  final double ratingAvg;
  final int ratingCount;

  const PassengerSnippetEntity({
    required this.id,
    required this.name,
    this.ratingAvg = 0.0,
    this.ratingCount = 0,
  });
}

class RideSnippetEntity {
  final String id;
  final String originAddress;
  final String destinationAddress;
  final DateTime departureTime;
  final String status;

  const RideSnippetEntity({
    required this.id,
    required this.originAddress,
    required this.destinationAddress,
    required this.departureTime,
    required this.status,
  });
}

class RideRequestEntity {
  final String id;
  final String rideId;
  final String passengerId;
  final String status;
  final DateTime createdAt;

  const RideRequestEntity({
    required this.id,
    required this.rideId,
    required this.passengerId,
    required this.status,
    required this.createdAt,
  });
}

class RideRequestWithPassengerEntity extends RideRequestEntity {
  final PassengerSnippetEntity passenger;
  final String? originAddress;
  final String? destinationAddress;

  const RideRequestWithPassengerEntity({
    required super.id,
    required super.rideId,
    required super.passengerId,
    required super.status,
    required super.createdAt,
    required this.passenger,
    required this.originAddress,
    required this.destinationAddress,
  });
}

class RideRequestWithRideEntity extends RideRequestEntity {
  final RideSnippetEntity ride;

  const RideRequestWithRideEntity({
    required super.id,
    required super.rideId,
    required super.passengerId,
    required super.status,
    required super.createdAt,
    required this.ride,
  });
}