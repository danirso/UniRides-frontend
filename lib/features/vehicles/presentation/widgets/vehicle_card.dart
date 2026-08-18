import 'package:flutter/material.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../../../../core/theme/app_theme.dart';

class VehicleCard extends StatelessWidget {
  final VehicleEntity vehicle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Semantics(
                  label: '${l10n.vehiclePlateLabel}: ${vehicle.plate}',
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.darkBackground,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      vehicle.plate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Semantics(
                      identifier: 'edit_vehicle_${vehicle.id}',
                      button: true,
                      label: l10n.editVehicleAction,
                      child: IconButton(
                        key: Key('edit_vehicle_${vehicle.id}'),
                        icon: const Icon(Icons.edit_outlined),
                        color: AppTheme.primaryTeal,
                        tooltip: l10n.editVehicleAction,
                        onPressed: onEdit,
                      ),
                    ),
                    Semantics(
                      identifier: 'delete_vehicle_${vehicle.id}',
                      button: true,
                      label: l10n.deleteVehicleAction,
                      child: IconButton(
                        key: Key('delete_vehicle_${vehicle.id}'),
                        icon: const Icon(Icons.delete_outline),
                        color: Colors.redAccent,
                        tooltip: l10n.deleteVehicleAction,
                        onPressed: onDelete,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Semantics(
              label:
                  '${l10n.vehicleBrandLabel}: ${vehicle.brand} ${vehicle.model}',
              child: Row(
                children: [
                  const Icon(
                    Icons.directions_car,
                    size: 18,
                    color: AppTheme.primaryTeal,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${vehicle.brand} ${vehicle.model}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Semantics(
              label: '${l10n.vehicleColorLabel}: ${vehicle.color}',
              child: Row(
                children: [
                  const Icon(
                    Icons.palette_outlined,
                    size: 18,
                    color: AppTheme.primaryTeal,
                  ),
                  const SizedBox(width: 8),
                  Text(vehicle.color, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Semantics(
              label: l10n.vehiclePassengersLabel(vehicle.capacity),
              child: Row(
                children: [
                  const Icon(
                    Icons.people_outline,
                    size: 18,
                    color: AppTheme.primaryTeal,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.vehiclePassengersLabel(vehicle.capacity),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
