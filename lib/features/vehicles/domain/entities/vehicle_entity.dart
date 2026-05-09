class VehicleEntity {
  final String id;
  final String ownerId;
  final String plate;
  final String brand;
  final String model;
  final String color;
  final int capacity;

  const VehicleEntity({
    required this.id,
    required this.ownerId,
    required this.plate,
    required this.brand,
    required this.model,
    required this.color,
    required this.capacity,
  });
}