import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../domain/entities/ride_entity.dart';
import '../controllers/ride_controller.dart';
import '../../../vehicles/presentation/controllers/vehicle_controller.dart';
import '../../../vehicles/domain/entities/vehicle_entity.dart';

class RideEditModal extends ConsumerStatefulWidget {
  final RideEntity ride;

  const RideEditModal({super.key, required this.ride});

  @override
  ConsumerState<RideEditModal> createState() => _RideEditModalState();
}

class _RideEditModalState extends ConsumerState<RideEditModal> {
  late int _availableSeats;
  late int _maxDetourKm;
  late DateTime _departureTime;
  VehicleEntity? _selectedVehicle;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _availableSeats = widget.ride.availableSeats;
    _maxDetourKm = (widget.ride.maxDetourMeters / 1000).round();
    _departureTime = widget.ride.departureTime;
    Future.microtask(
      () => ref.read(vehicleControllerProvider.notifier).fetchVehicles(),
    );
  }

  Future<void> _pickDepartureTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _departureTime,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_departureTime),
    );
    if (time == null || !mounted) return;

    setState(() {
      _departureTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);

    final success = await ref
        .read(rideControllerProvider.notifier)
        .updateRide(
          rideId: widget.ride.id,
          vehicleId: _selectedVehicle?.id,
          availableSeats: _availableSeats,
          maxDetourMeters: _maxDetourKm * 1000,
          departureTime: _departureTime,
        );

    if (!mounted) return;
    setState(() => _isLoading = false);

    final l10n = AppLocalizations.of(context)!;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? l10n.rideUpdatedSuccess : l10n.rideUpdatedError,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vehicleState = ref.watch(vehicleControllerProvider);

    return Semantics(
      identifier: 'modal_edit_ride',
      container: true,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                header: true,
                child: Text(
                  l10n.editRideAction,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              vehicleState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => const SizedBox.shrink(),
                data: (vehicles) {
                  if (vehicles.isEmpty) return const SizedBox.shrink();
                  if (_selectedVehicle == null) {
                    final match = vehicles.where(
                      (v) => v.id == widget.ride.vehicleId,
                    );
                    _selectedVehicle = match.isNotEmpty
                        ? match.first
                        : vehicles.first;
                  }
                  return Semantics(
                    identifier: 'edit_ride_vehicle_dropdown',
                    label: l10n.selectVehicleLabel,
                    child: DropdownButtonFormField<VehicleEntity>(
                      key: const Key('edit_ride_vehicle_dropdown'),
                      decoration: InputDecoration(
                        labelText: l10n.selectVehicleLabel,
                      ),
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
                identifier: 'edit_ride_departure_button',
                button: true,
                label: l10n.departureDateLabel,
                child: OutlinedButton.icon(
                  key: const Key('edit_ride_departure_button'),
                  onPressed: _pickDepartureTime,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    '${_departureTime.day.toString().padLeft(2, '0')}/'
                    '${_departureTime.month.toString().padLeft(2, '0')}/'
                    '${_departureTime.year} '
                    '${_departureTime.hour.toString().padLeft(2, '0')}:'
                    '${_departureTime.minute.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                identifier: 'edit_ride_seats_control',
                label: '${l10n.availableSeatsLabel}: $_availableSeats',
                child: Row(
                  children: [
                    Text(l10n.availableSeatsLabel),
                    const Spacer(),
                    Semantics(
                      identifier: 'edit_ride_seats_decrement',
                      button: true,
                      child: IconButton(
                        key: const Key('edit_ride_seats_decrement'),
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: _availableSeats > 1
                            ? () => setState(() => _availableSeats--)
                            : null,
                      ),
                    ),
                    Text(
                      '$_availableSeats',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Semantics(
                      identifier: 'edit_ride_seats_increment',
                      button: true,
                      child: IconButton(
                        key: const Key('edit_ride_seats_increment'),
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed:
                            _selectedVehicle != null &&
                                _availableSeats < _selectedVehicle!.capacity
                            ? () => setState(() => _availableSeats++)
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Semantics(
                identifier: 'edit_ride_detour_control',
                label:
                    '${l10n.maxDetourLabel}: ${l10n.maxDetourValue(_maxDetourKm)}',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${l10n.maxDetourLabel}: ${l10n.maxDetourValue(_maxDetourKm)}',
                    ),
                    Semantics(
                      identifier: 'edit_ride_detour_slider',
                      child: Slider(
                        key: const Key('edit_ride_detour_slider'),
                        value: _maxDetourKm.toDouble(),
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: l10n.maxDetourValue(_maxDetourKm),
                        onChanged: (v) =>
                            setState(() => _maxDetourKm = v.toInt()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Semantics(
                identifier: 'edit_ride_submit_button',
                button: true,
                label: l10n.saveVehicleAction,
                child: ElevatedButton(
                  key: const Key('edit_ride_submit_button'),
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.saveVehicleAction),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
