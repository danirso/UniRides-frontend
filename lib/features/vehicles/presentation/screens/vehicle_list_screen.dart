import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../controllers/vehicle_controller.dart';
import '../widgets/vehicle_card.dart';
import '../widgets/vehicle_edit_modal.dart';
import '../widgets/vehicle_registration_modal.dart';

class VehicleListScreen extends ConsumerStatefulWidget {
  const VehicleListScreen({super.key});

  @override
  ConsumerState<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends ConsumerState<VehicleListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(vehicleControllerProvider.notifier).fetchVehicles());
  }

  Future<void> _confirmDelete(BuildContext context, String vehicleId, String plate) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Semantics(
          header: true,
          child: Text(l10n.deleteVehicleConfirmTitle),
        ),
        content: Text(l10n.deleteVehicleConfirmMessage(plate)),
        actions: [
          TextButton(
            key: const Key('cancel_delete_vehicle_button'),
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            key: const Key('confirm_delete_vehicle_button'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.confirmAction),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final success = await ref
        .read(vehicleControllerProvider.notifier)
        .deleteVehicle(vehicleId);

    if (!context.mounted) return;

    final l10nPost = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? l10nPost.vehicleDeletedSuccess : l10nPost.vehicleDeletedError,
        ),
      ),
    );
  }

  void _openEditModal(BuildContext context, vehicle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => VehicleEditModal(vehicle: vehicle),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vehicleState = ref.watch(vehicleControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          header: true,
          child: Text(l10n.myVehiclesTitle),
        ),
      ),
      body: vehicleState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (vehicles) {
          if (vehicles.isEmpty) {
            return Center(
              child: Semantics(
                label: l10n.noVehiclesRegistered,
                child: Text(
                  l10n.noVehiclesRegistered,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return VehicleCard(
                key: Key('vehicle_card_${vehicle.id}'),
                vehicle: vehicle,
                onEdit: () => _openEditModal(context, vehicle),
                onDelete: () => _confirmDelete(context, vehicle.id, vehicle.plate),
              );
            },
          );
        },
      ),
      floatingActionButton: Semantics(
        button: true,
        label: l10n.registerVehicleTitle,
        child: FloatingActionButton(
          key: const Key('add_vehicle_fab'),
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const VehicleRegistrationModal(),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}