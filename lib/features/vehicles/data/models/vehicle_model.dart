import '../../domain/entities/vehicle_entity.dart';

class VehicleModel extends VehicleEntity {
  VehicleModel({
    required super.id,
    required super.ownerId,
    required super.plate,
    required super.brand,
    required super.model,
    required super.color,
    required super.capacity,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'].toString(),
      ownerId: json['owner_id'].toString(),
      plate: json['plate'],
      brand: json['brand'],
      model: json['model'],
      color: json['color'],
      capacity: json['capacity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plate': plate,
      'brand': brand,
      'model': model,
      'color': color,
      'capacity': capacity,
    };
  }
}