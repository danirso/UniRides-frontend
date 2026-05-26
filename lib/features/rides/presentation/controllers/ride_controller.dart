import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../vehicles/presentation/controllers/vehicle_controller.dart';
import '../../data/repositories/ride_repository_impl.dart';
import '../../domain/entities/ride_entity.dart';
import '../../domain/entities/ride_request_entity.dart';
import '../../domain/repositories/i_ride_repository.dart';

final rideRepositoryProvider = Provider<IRideRepository>((ref) {
  return RideRepositoryImpl(ref.watch(dioClientProvider));
});

final rideControllerProvider =
    NotifierProvider<RideController, List<RideEntity>>(RideController.new);

final myRequestsControllerProvider =
    NotifierProvider<MyRequestsController, List<RideRequestWithRideEntity>>(
        MyRequestsController.new);

final rideRequestsControllerProvider = NotifierProvider.family<
    RideRequestsController,
    List<RideRequestWithPassengerEntity>,
    String>(RideRequestsController.new);

final rideSearchControllerProvider = 
    NotifierProvider<RideSearchController, List<RideEntity>> (
        RideSearchController.new);

// ---------------------------------------------------------------------------
// RideController — caronas do motorista
// ---------------------------------------------------------------------------

class RideController extends Notifier<List<RideEntity>> {
  late IRideRepository _repository;

  @override
  List<RideEntity> build() {
    _repository = ref.watch(rideRepositoryProvider);
    return [];
  }

  Future<void> fetchMyRides() async {
    try {
      final rides = await _repository.getMyRides();
      state = rides;
    } catch (e) {
      state = [];
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
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateRide({
    required String rideId,
    String? vehicleId,
    int? availableSeats,
    int? maxDetourMeters,
    DateTime? departureTime,
  }) async {
    try {
      await _repository.updateRide(
        rideId: rideId,
        vehicleId: vehicleId,
        availableSeats: availableSeats,
        maxDetourMeters: maxDetourMeters,
        departureTime: departureTime,
      );
      await fetchMyRides();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> startRide(String rideId) async {
    try {
      await _repository.startRide(rideId);
      await fetchMyRides();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> completeRide(String rideId) async {
    try {
      await _repository.completeRide(rideId);
      await fetchMyRides();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancelRide(String rideId) async {
    try {
      await _repository.cancelRide(rideId);
      await fetchMyRides();
      return true;
    } catch (e) {
      return false;
    }
  }
}

// ---------------------------------------------------------------------------
// RideRequestsController — solicitações de uma carona específica (motorista)
// ---------------------------------------------------------------------------

class RideRequestsController
    extends Notifier<List<RideRequestWithPassengerEntity>> {
  late IRideRepository _repository;
  late final String _rideId;

  RideRequestsController(this._rideId);

  @override
  List<RideRequestWithPassengerEntity> build() {
    _repository = ref.watch(rideRepositoryProvider);
    return [];
  }

  Future<void> fetchRequests() async {
    try {
      final requests = await _repository.getRideRequests(_rideId);
      state = requests;
    } catch (e) {
      state = [];
    }
  }

  Future<bool> acceptRequest(String requestId) async {
    try {
      await _repository.acceptRequest(_rideId, requestId);
      await fetchRequests();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> rejectRequest(String requestId) async {
    try {
      await _repository.rejectRequest(_rideId, requestId);
      await fetchRequests();
      return true;
    } catch (e) {
      return false;
    }
  }
}

// ---------------------------------------------------------------------------
// MyRequestsController — solicitações do passageiro
// ---------------------------------------------------------------------------

class MyRequestsController
    extends Notifier<List<RideRequestWithRideEntity>> {
  late IRideRepository _repository;

  @override
  List<RideRequestWithRideEntity> build() {
    _repository = ref.watch(rideRepositoryProvider);
    return [];
  }

  Future<void> fetchMyRequests() async {
    try {
      final requests = await _repository.getMyRequests();
      state = requests;
    } catch (e) {
      state = [];
    }
  }

  Future<bool> cancelRequest(String rideId, String requestId) async {
    try {
      await _repository.cancelRequest(rideId, requestId);
      await fetchMyRequests();
      return true;
    } catch (e) {
      return false;
    }
  }
}

class RideSearchController extends Notifier<List<RideEntity>> {
    late IRideRepository _repository;

    @override
    List<RideEntity> build() {
      _repository = ref.watch(rideRepositoryProvider);
      return [];
    }

    Future<bool> searchRides({
      required double originLat,
      required double originLng,
      required double destinationLat,
      required double destinationLng,
    }) async {
      try {
        final rides = await _repository.searchRides(
          originLat: originLat,
          originLng: originLng,
          destinationLat: destinationLat,
          destinationLng: destinationLng,
        );
        state = rides;
        return true;
      } catch (e) {
        state = [];
        return false;
      }
    }

    void clearResults() => state = [];
}