import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../domain/entities/ride_entity.dart';
import '../controllers/ride_controller.dart';
import '../widgets/ride_request_card.dart';

class RideDetailScreen extends ConsumerStatefulWidget {
  final RideEntity ride;

  const RideDetailScreen({super.key, required this.ride});

  @override
  ConsumerState<RideDetailScreen> createState() => _RideDetailScreenState();
}

class _RideDetailScreenState extends ConsumerState<RideDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(rideRequestsControllerProvider(widget.ride.id).notifier)
        .fetchRequests());
  }

  Future<void> _handleAccept(String requestId) async {
    final l10n = AppLocalizations.of(context)!;
    final success = await ref
        .read(rideRequestsControllerProvider(widget.ride.id).notifier)
        .acceptRequest(requestId);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          success ? l10n.requestAcceptedSuccess : l10n.requestAcceptedError),
    ));
  }

  Future<void> _handleReject(String requestId) async {
    final l10n = AppLocalizations.of(context)!;
    final success = await ref
        .read(rideRequestsControllerProvider(widget.ride.id).notifier)
        .rejectRequest(requestId);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          success ? l10n.requestRejectedSuccess : l10n.requestRejectedError),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final requests = ref.watch(rideRequestsControllerProvider(widget.ride.id));

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          header: true,
          child: Text(l10n.rideRequestsTitle),
        ),
      ),
      body: requests.isEmpty
          ? Center(
              child: Semantics(
                label: l10n.noRequests,
                child: Text(
                  l10n.noRequests,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return RideRequestCard(
                  key: Key('request_card_${request.id}'),
                  request: request,
                  onAccept: () => _handleAccept(request.id),
                  onReject: () => _handleReject(request.id),
                );
              },
            ),
    );
  }
}