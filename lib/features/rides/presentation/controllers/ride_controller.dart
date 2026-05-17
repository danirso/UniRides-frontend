import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/ride_repository_impl.dart';
import '../../domain/entities/ride_entity.dart';
import '../../domain/repositories/i_ride_repository.dart';
import '../../../vehicles/presentation/controllers/vehicle_controller.dart';

final rideRepositoryProvider = Provider<IRideRepository>((ref) {
  return RideRepositoryImpl(ref.watch(dioClientProvider));
});

final rideControllerProvider =
    NotifierProvider<RideController, AsyncValue<List<RideEntity>>>(
        RideController.new);

class RideController extends Notifier<AsyncValue<List<RideEntity>>> {
  late IRideRepository _repository;

  @override
  AsyncValue<List<RideEntity>> build() {
    _repository = ref.watch(rideRepositoryProvider);
    return const AsyncValue.loading();
  }

  Future<void> fetchMyRides() async {
    state = const AsyncValue.loading();
    try {
      final rides = await _repository.getMyRides();
      state = AsyncValue.data(rides);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<RideEntity?> createRide({
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
      final ride = await _repository.createRide(
        vehicleId: vehicleId,
        originLat: originLat,
        originLng: originLng,
        destinationLat: destinationLat,
        destinationLng: destinationLng,
        originAddress: originAddress,
        destinationAddress: destinationAddress,
        departureTime: departureTime,
        availableSeats: availableSeats,
        maxDetourMeters: maxDetourMeters,
      );
      await fetchMyRides();
      return ride;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }
}