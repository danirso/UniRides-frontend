class PassengerSnippetEntity {
  final String id;
  final String name;

  const PassengerSnippetEntity({
    required this.id,
    required this.name,
  });
}

class RideSnippetEntity {
  final String id;
  final String originAddress;
  final String destinationAddress;
  final DateTime departureTime;

  const RideSnippetEntity({
    required this.id,
    required this.originAddress,
    required this.destinationAddress,
    required this.departureTime,
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

  const RideRequestWithPassengerEntity({
    required super.id,
    required super.rideId,
    required super.passengerId,
    required super.status,
    required super.createdAt,
    required this.passenger,
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