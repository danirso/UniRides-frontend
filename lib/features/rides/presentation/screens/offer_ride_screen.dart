import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../../vehicles/presentation/controllers/vehicle_controller.dart';
import '../../../vehicles/domain/entities/vehicle_entity.dart';
import '../controllers/ride_controller.dart';
import '../widgets/address_search_field.dart';

class OfferRideScreen extends ConsumerStatefulWidget {
  const OfferRideScreen({super.key});

  @override
  ConsumerState<OfferRideScreen> createState() => _OfferRideScreenState();
}

class _OfferRideScreenState extends ConsumerState<OfferRideScreen> {
  late final TextEditingController _originController;
  late final TextEditingController _destinationController;

  PlaceResult? _origin;
  PlaceResult? _destination;
  DateTime? _departureTime;
  VehicleEntity? _selectedVehicle;
  int _availableSeats = 1;
  int _maxDetourKm = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _originController = TextEditingController();
    _destinationController = TextEditingController();
    Future.microtask(() =>
        ref.read(vehicleControllerProvider.notifier).fetchVehicles());
  }

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _pickDepartureTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );
    if (time == null || !mounted) return;

    setState(() {
      _departureTime = DateTime(
        date.year, date.month, date.day,
        time.hour, time.minute,
      );
    });
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;

    if (_origin == null) {
      _showSnack(l10n.selectOriginFirst);
      return;
    }
    if (_destination == null) {
      _showSnack(l10n.selectDestinationFirst);
      return;
    }
    if (_departureTime == null) {
      _showSnack(l10n.selectDepartureFirst);
      return;
    }
    if (_selectedVehicle == null) {
      _showSnack(l10n.selectVehicleFirst);
      return;
    }

    setState(() => _isLoading = true);

    final ride = await ref.read(rideControllerProvider.notifier).createRide(
      vehicleId: _selectedVehicle!.id,
      originLat: _origin!.lat,
      originLng: _origin!.lng,
      destinationLat: _destination!.lat,
      destinationLng: _destination!.lng,
      originAddress: _origin!.address,
      destinationAddress: _destination!.address,
      departureTime: _departureTime!,
      availableSeats: _availableSeats,
      maxDetourMeters: _maxDetourKm * 1000,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    final l10nPost = AppLocalizations.of(context)!;
    if (ride != null) {
      _resetForm();
      _showSnack(l10nPost.rideCreatedSuccess);
    } else {
      _showSnack(l10nPost.rideCreatedError);
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _resetForm() {
    _originController.clear();
    _destinationController.clear();
    setState(() {
      _origin = null;
      _destination = null;
      _departureTime = null;
      _selectedVehicle = null;
      _availableSeats = 1;
      _maxDetourKm = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vehicleState = ref.watch(vehicleControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          header: true,
          child: Text(l10n.offerRideTitle),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AddressSearchField(
              label: l10n.originLabel,
              controller: _originController,
              widgetKey: 'origin',
              onPlaceSelected: (place) => setState(() => _origin = place),
            ),
            const SizedBox(height: 16),
            AddressSearchField(
              label: l10n.destinationLabel,
              controller: _destinationController,
              widgetKey: 'destination',
              onPlaceSelected: (place) => setState(() => _destination = place),
            ),
            const SizedBox(height: 16),
            Semantics(
              button: true,
              label: l10n.departureDateLabel,
              child: OutlinedButton.icon(
                key: const Key('departure_time_button'),
                onPressed: _pickDepartureTime,
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _departureTime == null
                      ? l10n.departureDateLabel
                      : '${_departureTime!.day.toString().padLeft(2, '0')}/'
                          '${_departureTime!.month.toString().padLeft(2, '0')}/'
                          '${_departureTime!.year} '
                          '${_departureTime!.hour.toString().padLeft(2, '0')}:'
                          '${_departureTime!.minute.toString().padLeft(2, '0')}',
                ),
              ),
            ),
            const SizedBox(height: 16),
            vehicleState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const SizedBox.shrink(),
              data: (vehicles) {
                if (vehicles.isEmpty) return const SizedBox.shrink();
                return Semantics(
                  label: l10n.selectVehicleLabel,
                  child: DropdownButtonFormField<VehicleEntity>(
                    key: const Key('vehicle_dropdown'),
                    decoration: InputDecoration(
                        labelText: l10n.selectVehicleLabel),
                    initialValue: _selectedVehicle,
                    items: vehicles.map((v) {
                      return DropdownMenuItem(
                        value: v,
                        child: Text('${v.brand} ${v.model} • ${v.plate}'),
                      );
                    }).toList(),
                    onChanged: (v) => setState(() {
                      _selectedVehicle = v;
                      if (v != null && _availableSeats > v.capacity) {
                        _availableSeats = v.capacity;
                      }
                    }),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Semantics(
              label: '${l10n.availableSeatsLabel}: $_availableSeats',
              child: Row(
                children: [
                  Text(l10n.availableSeatsLabel),
                  const Spacer(),
                  IconButton(
                    key: const Key('seats_decrement_button'),
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _availableSeats > 1
                        ? () => setState(() => _availableSeats--)
                        : null,
                  ),
                  Text(
                    '$_availableSeats',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    key: const Key('seats_increment_button'),
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _selectedVehicle != null &&
                            _availableSeats < _selectedVehicle!.capacity
                        ? () => setState(() => _availableSeats++)
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Semantics(
              label: '${l10n.maxDetourLabel}: ${l10n.maxDetourValue(_maxDetourKm)}',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${l10n.maxDetourLabel}: ${l10n.maxDetourValue(_maxDetourKm)}'),
                      const SizedBox(width: 4),
                      Semantics(
                        button: true,
                        label: l10n.maxDetourInfoLabel,
                        child: GestureDetector(
                          key: const Key('max_detour_info_button'),
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(l10n.maxDetourLabel),
                              content: Text(l10n.maxDetourInfoMessage),
                              actions: [
                                TextButton(
                                  key: const Key('max_detour_info_close_button'),
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(l10n.confirmAction),
                                ),
                              ],
                            ),
                          ),
                          child: const Icon(Icons.help_outline, size: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    key: const Key('max_detour_slider'),
                    value: _maxDetourKm.toDouble(),
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: l10n.maxDetourValue(_maxDetourKm),
                    onChanged: (v) => setState(() => _maxDetourKm = v.toInt()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Semantics(
              button: true,
              label: l10n.offerRideAction,
              child: ElevatedButton(
                key: const Key('offer_ride_submit_button'),
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.offerRideAction),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}