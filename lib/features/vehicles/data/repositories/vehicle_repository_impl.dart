import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/vehicle_model.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../../domain/repositories/i_vehicle_repository.dart';
import 'package:tcc_caronas_frontend/core/network/dio_client.dart';

class VehicleRepositoryImpl implements IVehicleRepository {
  final DioClient _client;

  VehicleRepositoryImpl(this._client);

  @override
  Future<List<VehicleEntity>> getMyVehicles() async {
    try {
      final response = await _client.instance.get('/vehicles/');
      final List data = response.data;
      return data.map((json) => VehicleModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao carregar veículos');
    }
  }

  @override
  Future<void> registerVehicle({
    required String plate,
    required String brand,
    required String model,
    required String color,
    required int capacity,
  }) async {
    try {
      await _client.instance.post(
        '/vehicles/',
        data: {
          'plate': plate,
          'brand': brand,
          'model': model,
          'color': color,
          'capacity': capacity,
        },
      );
    } on DioException catch (e) {
      debugPrint('Detalhes do Erro 422: ${e.response?.data}');
      throw Exception('Erro ao cadastrar veículo');
    }
  }
}