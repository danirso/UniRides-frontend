import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../../auth/presentation/controllers/user_controller.dart';
import '../controllers/ride_controller.dart';
import '../widgets/ride_card.dart';
import '../widgets/ride_edit_modal.dart';
import 'ride_detail_screen.dart';

class MyRidesScreen extends ConsumerStatefulWidget {
  const MyRidesScreen({super.key});

  @override
  ConsumerState<MyRidesScreen> createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends ConsumerState<MyRidesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _canDrive = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userControllerProvider).value;
    _canDrive = user?.canDrive ?? false;
    _tabController = TabController(
      length: _canDrive ? 2 : 1,
      vsync: this,
    );
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
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Semantics(header: true, child: Text(title)),
        content: Text(message),
        actions: [
          TextButton(
            key: const Key('cancel_action_button'),
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            key: const Key('confirm_action_button'),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.confirmAction),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final success = await action();
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(success ? successMessage : errorMessage),
    ));
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

    return ListView.builder(
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
          action: () => ref
              .read(rideControllerProvider.notifier)
              .startRide(ride.id),
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
          ),
          onCancel: () => _confirmAction(
            context: context,
            title: l10n.confirmCancelRideTitle,
            message: l10n.confirmCancelRideMessage,
            action: () => ref
                .read(rideControllerProvider.notifier)
                .cancelRide(ride.id),
            successMessage: l10n.rideCanceledSuccess,
            errorMessage: l10n.rideCanceledError,
          ),
        );
      },
    );
  }

  Widget _buildPassengerTab(BuildContext context, AppLocalizations l10n) {
    final requests = ref.watch(myRequestsControllerProvider);

    if (requests.isEmpty) {
      return Center(
        child: Semantics(
          label: l10n.noRidesAsPassenger,
          child: Text(
            l10n.noRidesAsPassenger,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        final isPending = request.status == 'pending';
        final isAccepted = request.status == 'accepted';

        return Card(
          key: Key('my_request_card_${request.id}'),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
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
                      const Icon(Icons.trip_origin,
                          size: 18, color: Color(0xFF679E96)),
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
                      const Icon(Icons.place_outlined,
                          size: 18, color: Colors.redAccent),
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
                      '${request.ride.departureTime.toLocal().day.toString().padLeft(2, '0')}/'
                      '${request.ride.departureTime.toLocal().month.toString().padLeft(2, '0')}/'
                      '${request.ride.departureTime.year} '
                      '${request.ride.departureTime.toLocal().hour.toString().padLeft(2, '0')}:'
                      '${request.ride.departureTime.toLocal().minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _requestStatusColor(request.status)
                            .withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: _requestStatusColor(request.status)),
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
                          foregroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.redAccent),
                        ),
                        child: Text(l10n.cancelRequestAction),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  String _localizedRequestStatus(AppLocalizations l10n, String status) {
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

  Color _requestStatusColor(String status) {
    switch (status) {
      case 'pending':
        return const Color(0xFFE3C598);
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

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          header: true,
          child: Text(l10n.myRidesTitle),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            if (_canDrive)
              Tab(
                key: const Key('driver_tab'),
                text: l10n.ridesAsDriverTab,
              ),
            Tab(
              key: const Key('passenger_tab'),
              text: l10n.ridesAsPassengerTab,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          if (_canDrive) _buildDriverTab(context, l10n),
          _buildPassengerTab(context, l10n),
        ],
      ),
    );
  }
}