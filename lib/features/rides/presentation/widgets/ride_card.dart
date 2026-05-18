import 'package:flutter/material.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../domain/entities/ride_entity.dart';
import '../../../../core/theme/app_theme.dart';

class RideCard extends StatelessWidget {
  final RideEntity ride;
  final VoidCallback onEdit;
  final VoidCallback onViewRequests;
  final VoidCallback? onStart;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;

  const RideCard({
    super.key,
    required this.ride,
    required this.onEdit,
    required this.onViewRequests,
    this.onStart,
    this.onComplete,
    this.onCancel,
  });

  String _localizedStatus(AppLocalizations l10n, String status) {
    switch (status) {
      case 'agendada':
        return l10n.rideStatusScheduled;
      case 'em_andamento':
        return l10n.rideStatusInProgress;
      case 'concluida':
        return l10n.rideStatusCompleted;
      case 'cancelada':
        return l10n.rideStatusCanceled;
      default:
        return status;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'agendada':
        return AppTheme.primaryTeal;
      case 'em_andamento':
        return AppTheme.sandYellow;
      case 'concluida':
        return Colors.green;
      case 'cancelada':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final statusColor = _statusColor(ride.status);
    final isScheduled = ride.status == 'agendada';
    final isInProgress = ride.status == 'em_andamento';

    return Card(
      key: Key('ride_card_${ride.id}'),
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
                  label: '${l10n.rideStatusScheduled}: ${_localizedStatus(l10n, ride.status)}',
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      _localizedStatus(l10n, ride.status),
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    if (isScheduled) ...[
                      Semantics(
                        button: true,
                        label: l10n.editRideAction,
                        child: IconButton(
                          key: Key('edit_ride_${ride.id}'),
                          icon: const Icon(Icons.edit_outlined),
                          color: AppTheme.primaryTeal,
                          tooltip: l10n.editRideAction,
                          onPressed: onEdit,
                        ),
                      ),
                      Semantics(
                        button: true,
                        label: l10n.cancelRideAction,
                        child: IconButton(
                          key: Key('cancel_ride_${ride.id}'),
                          icon: const Icon(Icons.cancel_outlined),
                          color: Colors.redAccent,
                          tooltip: l10n.cancelRideAction,
                          onPressed: onCancel,
                        ),
                      ),
                    ],
                    if (isInProgress)
                      Semantics(
                        button: true,
                        label: l10n.completeRideAction,
                        child: IconButton(
                          key: Key('complete_ride_${ride.id}'),
                          icon: const Icon(Icons.check_circle_outline),
                          color: Colors.green,
                          tooltip: l10n.completeRideAction,
                          onPressed: onComplete,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Semantics(
              label: '${l10n.originLabel}: ${ride.originAddress}',
              child: Row(
                children: [
                  const Icon(Icons.trip_origin, size: 18, color: AppTheme.primaryTeal),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      ride.originAddress,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Semantics(
              label: '${l10n.destinationLabel}: ${ride.destinationAddress}',
              child: Row(
                children: [
                  const Icon(Icons.place_outlined, size: 18, color: Colors.redAccent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      ride.destinationAddress,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Semantics(
              label: '${l10n.departureDateLabel}: ${ride.departureTime}',
              child: Row(
                children: [
                  const Icon(Icons.schedule, size: 18, color: AppTheme.primaryTeal),
                  const SizedBox(width: 8),
                  Text(
                    '${ride.departureTime.day.toString().padLeft(2, '0')}/'
                    '${ride.departureTime.month.toString().padLeft(2, '0')}/'
                    '${ride.departureTime.year} '
                    '${ride.departureTime.hour.toString().padLeft(2, '0')}:'
                    '${ride.departureTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Semantics(
              label: '${l10n.availableSeatsLabel}: ${ride.availableSeats}',
              child: Row(
                children: [
                  const Icon(Icons.people_outline, size: 18, color: AppTheme.primaryTeal),
                  const SizedBox(width: 8),
                  Text(
                    l10n.vehiclePassengersLabel(ride.availableSeats),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            if (isScheduled) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Semantics(
                      button: true,
                      label: l10n.viewRequestsAction,
                      child: OutlinedButton.icon(
                        key: Key('view_requests_${ride.id}'),
                        onPressed: onViewRequests,
                        icon: const Icon(Icons.people),
                        label: Text(l10n.viewRequestsAction),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Semantics(
                      button: true,
                      label: l10n.startRideAction,
                      child: OutlinedButton.icon(
                        key: Key('start_ride_${ride.id}'),
                        onPressed: onStart,
                        icon: const Icon(Icons.play_arrow),
                        label: Text(l10n.startRideAction),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (isInProgress) ...[
              const SizedBox(height: 12),
              Semantics(
                button: true,
                label: l10n.viewRequestsAction,
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    key: Key('view_requests_${ride.id}'),
                    onPressed: onViewRequests,
                    icon: const Icon(Icons.people),
                    label: Text(l10n.viewRequestsAction),
                  ),
                ),
              ),
            ],
          ],  
        ),
      ),
    );
  }
}