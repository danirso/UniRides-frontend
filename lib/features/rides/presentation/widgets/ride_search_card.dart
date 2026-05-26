import 'package:flutter/material.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../domain/entities/ride_entity.dart';
import '../../../../core/theme/app_theme.dart';
import '../screens/ride_detail_passenger.dart';

class RideSearchCard extends StatelessWidget {
  final RideEntity ride;
  final VoidCallback onRequestSeat;

  const RideSearchCard({
    super.key,
    required this.ride,
    required this.onRequestSeat,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      key: Key('ride_search_card_${ride.id}'),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: '${l10n.driverLabel}: ${ride.driverName}',
              child: Row(
                children: [
                  const Icon(Icons.person_outline,
                      size: 18, color: AppTheme.primaryTeal),
                  const SizedBox(width: 8),
                  Text(
                    ride.driverName,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Semantics(
              label: '${l10n.originLabel}: ${ride.originAddress}',
              child: Row(
                children: [
                  const Icon(Icons.trip_origin,
                      size: 18, color: AppTheme.primaryTeal),
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
                  const Icon(Icons.place_outlined,
                      size: 18, color: Colors.redAccent),
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
            const SizedBox(height: 10),
            Row(
              children: [
                Semantics(
                  label:
                      '${l10n.departureDateLabel}: ${ride.departureTime.day.toString().padLeft(2, '0')}/${ride.departureTime.month.toString().padLeft(2, '0')}/${ride.departureTime.year}',
                  child: Row(
                    children: [
                      const Icon(Icons.schedule,
                          size: 16, color: AppTheme.primaryTeal),
                      const SizedBox(width: 4),
                      Text(
                        '${ride.departureTime.day.toString().padLeft(2, '0')}/'
                        '${ride.departureTime.month.toString().padLeft(2, '0')}/'
                        '${ride.departureTime.year} '
                        '${ride.departureTime.hour.toString().padLeft(2, '0')}:'
                        '${ride.departureTime.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Semantics(
                  label: '${l10n.availableSeatsLabel}: ${ride.availableSeats}',
                  child: Row(
                    children: [
                      const Icon(Icons.people_outline,
                          size: 16, color: AppTheme.primaryTeal),
                      const SizedBox(width: 4),
                      Text(
                        l10n.vehiclePassengersLabel(ride.availableSeats),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Semantics(
                  label:
                      '${l10n.estimatedTimeLabel}: ${l10n.minutesLabel(ride.estimatedDurationMins)}',
                  child: Row(
                    children: [
                      const Icon(Icons.av_timer,
                          size: 16, color: AppTheme.primaryTeal),
                      const SizedBox(width: 4),
                      Text(
                        l10n.minutesLabel(ride.estimatedDurationMins),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Semantics(
                  label:
                      '${l10n.distanceLabel}: ${l10n.kilometersLabel(ride.distanceKm.toStringAsFixed(1))}',
                  child: Row(
                    children: [
                      const Icon(Icons.straighten,
                          size: 16, color: AppTheme.primaryTeal),
                      const SizedBox(width: 4),
                      Text(
                        l10n.kilometersLabel(
                            ride.distanceKm.toStringAsFixed(1)),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    button: true,
                    label: l10n.viewDetailsAction,
                    child: OutlinedButton(
                      key: Key('view_details_${ride.id}'),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RideDetailPassengerScreen(
                            ride: ride,
                            onRequestSeat: onRequestSeat,
                          ),
                        ),
                      ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor:AppTheme.sandYellow,
                    ),
                    child: Text(l10n.viewDetailsAction),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Semantics(
                    button: true,
                    label: l10n.requestSeatAction,
                    child: OutlinedButton(
                      key: Key('request_seat_${ride.id}'),
                      onPressed: onRequestSeat,
                      child: Text(l10n.requestSeatAction),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}