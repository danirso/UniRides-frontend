import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../controllers/ride_controller.dart';
import '../widgets/address_search_field.dart';
import '../widgets/ride_search_card.dart';
import '../../data/repositories/ride_repository_impl.dart';
import 'package:tcc_caronas_frontend/core/network/dio_provider.dart';

class SearchRidesScreen extends ConsumerStatefulWidget {
  const SearchRidesScreen({super.key});

  @override
  ConsumerState<SearchRidesScreen> createState() => _SearchRidesScreenState();
}

class _SearchRidesScreenState extends ConsumerState<SearchRidesScreen> {
  late final TextEditingController _originController;
  late final TextEditingController _destinationController;

  PlaceResult? _origin;
  PlaceResult? _destination;
  bool _isLoading = false;
  bool _searched = false;

  @override
  void initState() {
    super.initState();
    _originController = TextEditingController();
    _destinationController = TextEditingController();
  }

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final l10n = AppLocalizations.of(context)!;

    if (_origin == null) {
      _showSnack(l10n.selectOriginFirst);
      return;
    }
    if (_destination == null) {
      _showSnack(l10n.selectDestinationFirst);
      return;
    }

    setState(() {
      _isLoading = true;
      _searched = false;
    });

    await ref
        .read(rideSearchControllerProvider.notifier)
        .searchRides(
          originLat: _origin!.lat,
          originLng: _origin!.lng,
          destinationLat: _destination!.lat,
          destinationLng: _destination!.lng,
        );

    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _searched = true;
    });
  }

  Future<void> _requestSeat(String rideId) async {
    final l10n = AppLocalizations.of(context)!;

    if (_origin == null || _destination == null) return;

    final repo = RideRepositoryImpl(ref.read(dioClientProvider));

    try {
      await repo.requestSeat(
        rideId: rideId,
        originLat: _origin!.lat,
        originLng: _origin!.lng,
        destinationLat: _destination!.lat,
        destinationLng: _destination!.lng,
        originAddress: _origin!.address,
        destinationAddress: _destination!.address,
      );
      if (!mounted) return;
      ref.read(myRequestsControllerProvider.notifier).fetchMyRequests();
      _showSnack(l10n.rideRequestedSuccess);
    } catch (e) {
      if (!mounted) return;
      _showSnack(l10n.rideRequestedError);
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rides = ref.watch(rideSearchControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          identifier: 'screen_search_rides',
          header: true,
          child: Text(l10n.searchRidesTitle),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AddressSearchField(
              label: l10n.originLabel,
              widgetKey: 'search_origin',
              controller: _originController,
              onPlaceSelected: (place) => setState(() => _origin = place),
            ),
            const SizedBox(height: 12),
            AddressSearchField(
              label: l10n.destinationLabel,
              widgetKey: 'search_destination',
              controller: _destinationController,
              onPlaceSelected: (place) => setState(() => _destination = place),
            ),
            const SizedBox(height: 12),
            Semantics(
              identifier: 'search_rides_button',
              button: true,
              label: l10n.searchRidesAction,
              child: ElevatedButton(
                key: const Key('search_rides_button'),
                onPressed: _isLoading ? null : _search,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.searchRidesAction),
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              Center(child: Text(l10n.searchingRides))
            else if (_searched && rides.isEmpty)
              Center(
                child: Semantics(
                  identifier: 'search_rides_empty_state',
                  label: l10n.noRidesFound,
                  child: Text(
                    l10n.noRidesFound,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else if (_searched)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rides.length,
                itemBuilder: (context, index) {
                  final ride = rides[index];
                  return RideSearchCard(
                    ride: ride,
                    onRequestSeat: () => _requestSeat(ride.id),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
