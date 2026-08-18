import 'package:flutter/material.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../domain/entities/ride_request_entity.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../review/presentation/widgets/rating_badge.dart';

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
      case 'PENDING':
        return l10n.rideStatusPending;
      case 'ACCEPTED':
        return l10n.rideStatusAccepted;
      case 'REJECTED':
        return l10n.rideStatusRejected;
      case 'CANCELED':
        return l10n.rideStatusCanceled;
      default:
        return status;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'PENDING':
        return AppTheme.sandYellow;
      case 'ACCEPTED':
        return Colors.green;
      case 'REJECTED':
      case 'CANCELED':
        return AppTheme.dangerRed;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPending = request.status == 'PENDING';
    final statusColor = _statusColor(request.status);

    return Semantics(
      identifier: 'request_card_${request.id}',
      container: true,
      child: Card(
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
                  Expanded(
                    child: Semantics(
                      label: request.passenger.name,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 20,
                            color: AppTheme.primaryTeal,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              request.passenger.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          RatingBadge(
                            ratingAvg: request.passenger.ratingAvg,
                            ratingCount: request.passenger.ratingCount,
                            userId: request.passengerId,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
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
              if (request.originAddress != null) ...[
                const SizedBox(height: 8),
                Semantics(
                  label: request.originAddress!,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.radio_button_checked,
                        size: 16,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          request.originAddress!,
                          style: const TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (request.destinationAddress != null) ...[
                const SizedBox(height: 4),
                Semantics(
                  label: request.destinationAddress!,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.place,
                        size: 16,
                        color: AppTheme.dangerRed,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          request.destinationAddress!,
                          style: const TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (isPending) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        identifier: 'reject_request_${request.id}',
                        button: true,
                        label: l10n.rejectRequestAction,
                        child: OutlinedButton(
                          key: Key('reject_request_${request.id}'),
                          onPressed: onReject,
                          style: FilledButton.styleFrom(
                            foregroundColor: AppTheme.dangerRed,
                            side: const BorderSide(color: AppTheme.dangerRed),
                          ),
                          child: Text(l10n.rejectRequestAction),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Semantics(
                        identifier: 'accept_request_${request.id}',
                        button: true,
                        label: l10n.acceptRequestAction,
                        child: FilledButton(
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
      ),
    );
  }
}
