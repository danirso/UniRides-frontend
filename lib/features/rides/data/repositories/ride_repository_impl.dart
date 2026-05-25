import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/ride_entity.dart';
import '../../domain/entities/ride_request_entity.dart';
import '../../domain/repositories/i_ride_repository.dart';
import '../models/ride_model.dart';
import '../models/ride_request_model.dart';
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
          'departure_time': departureTime.toIso8601String(),
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

  @override
  Future<RideEntity> updateRide({
    required String rideId,
    String? vehicleId,
    int? availableSeats,
    int? maxDetourMeters,
    DateTime? departureTime,
  }) async {
    try {
      final data = {
        'vehicle_id': vehicleId,
        'available_seats': availableSeats,
        'max_detour_meters': maxDetourMeters,
        'departure_time': departureTime?.toIso8601String(),
      }..removeWhere((key, value) => value == null);

      final response = await _client.instance.patch('/rides/$rideId', data: data);
      return RideModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Erro ao atualizar carona: ${e.response?.data}');
      throw Exception('Erro ao atualizar carona');
    }
  }

  @override
  Future<RideEntity> startRide(String rideId) async {
    try {
      final response = await _client.instance.post('/rides/$rideId/start');
      return RideModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Erro ao iniciar carona: ${e.response?.data}');
      throw Exception('Erro ao iniciar carona');
    }
  }

  @override
  Future<RideEntity> completeRide(String rideId) async {
    try {
      final response = await _client.instance.post('/rides/$rideId/complete');
      return RideModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Erro ao finalizar carona: ${e.response?.data}');
      throw Exception('Erro ao finalizar carona');
    }
  }

  @override
  Future<RideEntity> cancelRide(String rideId) async {
    try {
      final response = await _client.instance.post('/rides/$rideId/cancel');
      return RideModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Erro ao cancelar carona: ${e.response?.data}');
      throw Exception('Erro ao cancelar carona');
    }
  }

  @override
  Future<List<RideRequestWithPassengerEntity>> getRideRequests(String rideId) async {
    try {
      final response = await _client.instance.get('/rides/$rideId/list-requests');
      final List data = response.data;
      return data.map((json) => RideRequestWithPassengerModel.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint('Erro ao carregar solicitações: ${e.response?.data}');
      throw Exception('Erro ao carregar solicitações');
    }
  }

  @override
  Future<RideRequestWithPassengerEntity> acceptRequest(String rideId, String requestId) async {
    try {
      final response = await _client.instance.post('/rides/$rideId/requests/$requestId/accept');
      return RideRequestWithPassengerModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Erro ao aceitar solicitação: ${e.response?.data}');
      throw Exception('Erro ao aceitar solicitação');
    }
  }

  @override
  Future<RideRequestWithPassengerEntity> rejectRequest(String rideId, String requestId) async {
    try {
      final response = await _client.instance.post('/rides/$rideId/requests/$requestId/reject');
      return RideRequestWithPassengerModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Erro ao rejeitar solicitação: ${e.response?.data}');
      throw Exception('Erro ao rejeitar solicitação');
    }
  }

  @override
  Future<List<RideRequestWithRideEntity>> getMyRequests() async {
    try {
      final response = await _client.instance.get('/rides/requests/me');
      final List data = response.data;
      return data.map((json) => RideRequestWithRideModel.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint('Erro ao carregar minhas solicitações: ${e.response?.data}');
      throw Exception('Erro ao carregar minhas solicitações');
    }
  }

  @override
  Future<void> cancelRequest(String rideId, String requestId) async {
    try {
      await _client.instance.post('/rides/$rideId/requests/$requestId/cancel');
    } on DioException catch (e) {
      debugPrint('Erro ao cancelar solicitação: ${e.response?.data}');
      throw Exception('Erro ao cancelar solicitação');
    }
  }
}