import '../../domain/entities/vehicle_entity.dart';

class VehicleModel extends VehicleEntity {
  VehicleModel({
    required super.id,
    required super.ownerId,
    required super.plate,
    required super.model,
    required super.color,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'].toString(),
      ownerId: json['owner_id'].toString(),
      plate: json['plate'],
      model: json['model'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plate': plate,
      'model': model,
      'color': color,
    };
  }
}