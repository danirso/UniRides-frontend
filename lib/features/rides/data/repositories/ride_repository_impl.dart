import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/ride_entity.dart';
import '../../domain/repositories/i_ride_repository.dart';
import '../models/ride_model.dart';
import 'package:tcc_caronas_frontend/core/network/dio_client.dart';

class RideRepositoryImpl implements IRideRepository {
  final DioClient _client;

  RideRepositoryImpl(this._client);

  @override
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
  }) async {
    try {
      final response = await _client.instance.post(
        '/rides/',
        data: {
          'vehicle_id': vehicleId,
          'origin_lat': originLat,
          'origin_lng': originLng,
          'destination_lat': destinationLat,
          'destination_lng': destinationLng,
          'origin_address': originAddress,
          'destination_address': destinationAddress,
          'departure_time': departureTime.toUtc().toIso8601String(),
          'available_seats': availableSeats,
          'max_detour_meters': maxDetourMeters,
        },
      );
      return RideModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Erro ao criar carona: ${e.response?.data}');
      throw Exception('Erro ao criar carona');
    }
  }

  @override
  Future<List<RideEntity>> getMyRides() async {
    try {
      final response = await _client.instance.get('/rides/me');
      final List data = response.data;
      return data.map((json) => RideModel.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint('Erro ao carregar caronas: ${e.response?.data}');
      throw Exception('Erro ao carregar caronas');
    }
  }
}