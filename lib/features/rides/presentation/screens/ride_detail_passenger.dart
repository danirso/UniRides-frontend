import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../domain/entities/ride_entity.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../review/presentation/widgets/rating_badge.dart';

class RideDetailPassengerScreen extends StatelessWidget {
  final RideEntity ride;
  final VoidCallback onRequestSeat;

  const RideDetailPassengerScreen({
    super.key,
    required this.ride,
    required this.onRequestSeat,
  });

  List<LatLng> _decodePolyline(String encoded) {
    final decoded = decodePolyline(encoded);
    return decoded.map((p) => LatLng(p[0].toDouble(), p[1].toDouble())).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final points = _decodePolyline(ride.routePolyline);
    final bounds = LatLngBounds.fromPoints(points);

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          header: true,
          child: Text(l10n.rideDetailsTitle),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: FlutterMap(
              options: MapOptions(
                initialCameraFit: CameraFit.bounds(
                  bounds: bounds,
                  padding: const EdgeInsets.all(40),
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile-a.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.tcc.caronas',
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: points,
                      strokeWidth: 4,
                      color: Colors.lightBlue,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: points.first,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.radio_button_checked,
                        color: Colors.black,
                        size: 27,
                      ),
                    ),
                    Marker(
                      point: points.last,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.place,
                        color: AppTheme.dangerRed,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Semantics(
                    label: '${l10n.driverLabel}: ${ride.driverName}',
                    child: Row(
                      children: [
                        const Icon(Icons.person,
                            size: 18, color: AppTheme.primaryTeal),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            ride.driverName,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        RatingBadge(
                          ratingAvg: ride.driverRatingAvg,
                          ratingCount: ride.driverRatingCount,
                          userId: ride.driverId,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Semantics(
                    label: '${l10n.originLabel}: ${ride.originAddress}',
                    child: Row(
                      children: [
                        const Icon(Icons.radio_button_checked,
                            size: 18, color: Colors.black),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            ride.originAddress,
                            style: const TextStyle(fontSize: 14),
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
                        const Icon(Icons.place,
                            size: 18, color: AppTheme.dangerRed),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            ride.destinationAddress,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.access_time_filled,
                          size: 18, color: AppTheme.primaryTeal),
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
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.timer,
                          size: 16, color: AppTheme.primaryTeal),
                      const SizedBox(width: 8),
                      Text(l10n.minutesLabel(ride.estimatedDurationMins),
                          style: const TextStyle(fontSize: 13)),
                      const SizedBox(width: 16),
                      const Icon(Icons.route,
                          size: 16, color: AppTheme.primaryTeal),
                      const SizedBox(width: 8),
                      Text(
                          l10n.kilometersLabel(
                              ride.distanceKm.toStringAsFixed(1)),
                          style: const TextStyle(fontSize: 13)),
                      const SizedBox(width: 16),
                      const Icon(Icons.people,
                          size: 16, color: AppTheme.primaryTeal),
                      const SizedBox(width: 8),
                      Text(l10n.vehiclePassengersLabel(ride.availableSeats),
                          style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Semantics(
                    button: true,
                    label: l10n.requestSeatAction,
                    child: ElevatedButton(
                      key: const Key('request_seat_detail_button'),
                      onPressed: onRequestSeat,
                      child: Text(l10n.requestSeatAction),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}