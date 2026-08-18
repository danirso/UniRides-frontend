import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/core/theme/app_theme.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../../auth/presentation/controllers/user_controller.dart';
import '../controllers/ride_controller.dart';
import '../widgets/ride_card.dart';
import '../widgets/ride_edit_modal.dart';
import 'ride_detail_screen.dart';
import '../../../review/presentation/widgets/pending_reviews_modal.dart';

class MyRidesScreen extends ConsumerStatefulWidget {
  const MyRidesScreen({super.key});

  @override
  ConsumerState<MyRidesScreen> createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends ConsumerState<MyRidesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final canDrive = ref.read(userControllerProvider).value?.canDrive ?? false;
    _tabController = TabController(length: canDrive ? 2 : 1, vsync: this);
    Future.microtask(() {
      ref.read(rideControllerProvider.notifier).fetchMyRides();
      ref.read(myRequestsControllerProvider.notifier).fetchMyRequests();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _confirmAction({
    required BuildContext context,
    required String title,
    required String message,
    required Future<bool> Function() action,
    required String successMessage,
    required String errorMessage,
    VoidCallback? onSuccess,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => Semantics(
        identifier: 'dialog_confirm_ride_action',
        container: true,
        child: AlertDialog(
          title: Semantics(header: true, child: Text(title)),
          content: Text(message),
          actions: [
            Semantics(
              identifier: 'cancel_action_button',
              button: true,
              child: TextButton(
                key: const Key('cancel_action_button'),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
            ),
            Semantics(
              identifier: 'confirm_action_button',
              button: true,
              child: ElevatedButton(
                key: const Key('confirm_action_button'),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppLocalizations.of(context)!.confirmAction),
              ),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final success = await action();
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? successMessage : errorMessage)),
    );

    if (success && onSuccess != null) {
      onSuccess();
    }
  }

  Widget _buildDriverTab(BuildContext context, AppLocalizations l10n) {
    final rides = ref.watch(rideControllerProvider);

    if (rides.isEmpty) {
      return Center(
        child: Semantics(
          label: l10n.noRidesAsDriver,
          child: Text(
            l10n.noRidesAsDriver,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(myRequestsControllerProvider.notifier).fetchMyRequests(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: rides.length,
        itemBuilder: (context, index) {
          final ride = rides[index];
          return RideCard(
            ride: ride,
            onEdit: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => RideEditModal(ride: ride),
            ),
            onViewRequests: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RideDetailScreen(ride: ride),
              ),
            ),
            onStart: () => _confirmAction(
              context: context,
              title: l10n.confirmStartRideTitle,
              message: l10n.confirmStartRideMessage,
              action: () =>
                  ref.read(rideControllerProvider.notifier).startRide(ride.id),
              successMessage: l10n.rideStartedSuccess,
              errorMessage: l10n.rideStartedError,
            ),
            onComplete: () => _confirmAction(
              context: context,
              title: l10n.confirmCompleteRideTitle,
              message: l10n.confirmCompleteRideMessage,
              action: () => ref
                  .read(rideControllerProvider.notifier)
                  .completeRide(ride.id),
              successMessage: l10n.rideCompletedSuccess,
              errorMessage: l10n.rideCompletedError,
              onSuccess: () => PendingReviewsModal.show(context, ride.id),
            ),
            onCancel: () => _confirmAction(
              context: context,
              title: l10n.confirmCancelRideTitle,
              message: l10n.confirmCancelRideMessage,
              action: () =>
                  ref.read(rideControllerProvider.notifier).cancelRide(ride.id),
              successMessage: l10n.rideCanceledSuccess,
              errorMessage: l10n.rideCanceledError,
            ),
          );
        },
      ),
    );
  }

  Widget _buildPassengerTab(BuildContext context, AppLocalizations l10n) {
    final requests = ref.watch(myRequestsControllerProvider);

    if (requests.isEmpty) {
      return Center(
        child: Semantics(
          identifier: 'my_requests_empty_state',
          label: l10n.noRidesAsPassenger,
          child: Text(
            l10n.noRidesAsPassenger,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(myRequestsControllerProvider.notifier).fetchMyRequests(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          final isPending = request.status == 'PENDING';
          final isAccepted = request.status == 'ACCEPTED';
          final isRideCompleted = request.ride.status == 'concluida';

          return Semantics(
            identifier: 'my_request_card_${request.id}',
            container: true,
            child: Card(
              key: Key('my_request_card_${request.id}'),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      label: request.ride.originAddress,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.radio_button_checked,
                            size: 18,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              request.ride.originAddress,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Semantics(
                      label: request.ride.destinationAddress,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.place,
                            size: 18,
                            color: AppTheme.dangerRed,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              request.ride.destinationAddress,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${request.ride.departureTime.day.toString().padLeft(2, '0')}/'
                          '${request.ride.departureTime.month.toString().padLeft(2, '0')}/'
                          '${request.ride.departureTime.year} '
                          '${request.ride.departureTime.hour.toString().padLeft(2, '0')}:'
                          '${request.ride.departureTime.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _requestStatusColor(
                              request.status,
                            ).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _requestStatusColor(request.status),
                            ),
                          ),
                          child: Text(
                            _localizedRequestStatus(l10n, request.status),
                            style: TextStyle(
                              color: _requestStatusColor(request.status),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isPending || isAccepted) ...[
                      const SizedBox(height: 12),
                      Semantics(
                        identifier: 'cancel_request_${request.id}',
                        button: true,
                        label: l10n.cancelRequestAction,
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            key: Key('cancel_request_${request.id}'),
                            onPressed: () => _confirmAction(
                              context: context,
                              title: l10n.confirmCancelRequestTitle,
                              message: l10n.confirmCancelRequestMessage,
                              action: () => ref
                                  .read(myRequestsControllerProvider.notifier)
                                  .cancelRequest(request.rideId, request.id),
                              successMessage: l10n.requestCanceledSuccess,
                              errorMessage: l10n.requestCanceledError,
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.dangerRed,
                              side: const BorderSide(color: AppTheme.dangerRed),
                            ),
                            child: Text(l10n.cancelRequestAction),
                          ),
                        ),
                      ),
                    ],
                    if (isAccepted && isRideCompleted) ...[
                      const SizedBox(height: 12),
                      Semantics(
                        identifier: 'rate_driver_${request.rideId}',
                        button: true,
                        label: l10n.rateDriverAction,
                        child: SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            key: Key('rate_driver_${request.rideId}'),
                            onPressed: () => PendingReviewsModal.show(
                              context,
                              request.rideId,
                            ),
                            icon: const Icon(Icons.star_rounded),
                            label: Text(l10n.rateDriverAction),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _localizedRequestStatus(AppLocalizations l10n, String status) {
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

  Color _requestStatusColor(String status) {
    switch (status) {
      case 'PENDING':
        return Colors.amber;
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
    final canDrive = ref.watch(userControllerProvider).value?.canDrive ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          identifier: 'screen_my_rides',
          header: true,
          child: Text(l10n.myRidesTitle),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            if (canDrive)
              Tab(
                key: const Key('driver_tab'),
                child: Semantics(
                  identifier: 'driver_tab',
                  child: Text(l10n.ridesAsDriverTab),
                ),
              ),
            Tab(
              key: const Key('passenger_tab'),
              child: Semantics(
                identifier: 'passenger_tab',
                child: Text(l10n.ridesAsPassengerTab),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          if (canDrive) _buildDriverTab(context, l10n),
          _buildPassengerTab(context, l10n),
        ],
      ),
    );
  }
}
