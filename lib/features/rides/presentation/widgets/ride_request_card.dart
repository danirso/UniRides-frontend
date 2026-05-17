import 'package:flutter/material.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../domain/entities/ride_request_entity.dart';
import '../../../../core/theme/app_theme.dart';

class RideRequestCard extends StatelessWidget {
  final RideRequestWithPassengerEntity request;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const RideRequestCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onReject,
  });

  String _localizedStatus(AppLocalizations l10n, String status) {
    switch (status) {
      case 'pending':
        return l10n.rideStatusPending;
      case 'accepted':
        return l10n.rideStatusAccepted;
      case 'rejected':
        return l10n.rideStatusRejected;
      case 'canceled':
        return l10n.rideStatusCanceled;
      default:
        return status;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'pending':
        return AppTheme.sandYellow;
      case 'accepted':
        return Colors.green;
      case 'rejected':
      case 'canceled':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPending = request.status == 'pending';
    final statusColor = _statusColor(request.status);

    return Card(
      key: Key('request_card_${request.id}'),
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
                  label: request.passenger.name,
                  child: Row(
                    children: [
                      const Icon(Icons.person_outline,
                          size: 20, color: AppTheme.primaryTeal),
                      const SizedBox(width: 8),
                      Text(
                        request.passenger.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    _localizedStatus(l10n, request.status),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            if (isPending) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Semantics(
                      button: true,
                      label: l10n.rejectRequestAction,
                      child: OutlinedButton(
                        key: Key('reject_request_${request.id}'),
                        onPressed: onReject,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.redAccent),
                        ),
                        child: Text(l10n.rejectRequestAction),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Semantics(
                      button: true,
                      label: l10n.acceptRequestAction,
                      child: ElevatedButton(
                        key: Key('accept_request_${request.id}'),
                        onPressed: onAccept,
                        child: Text(l10n.acceptRequestAction),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}