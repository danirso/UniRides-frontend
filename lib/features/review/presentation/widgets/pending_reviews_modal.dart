import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../controllers/pending_reviews_controller.dart';
import '../../domain/entities/pending_review_target_entity.dart';
import 'review_form_widget.dart';

class PendingReviewsModal extends ConsumerWidget {
  final String rideId;

  const PendingReviewsModal({super.key, required this.rideId});

  static Future<void> show(BuildContext context, String rideId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => PendingReviewsModal(rideId: rideId),
    );
  }

  void _openReviewForm(BuildContext context, PendingReviewTargetEntity target) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ReviewFormWidget(rideId: rideId, target: target),
    );
  }

  String _roleLabel(AppLocalizations l10n, ReviewTargetRole role) {
    return role == ReviewTargetRole.driver
        ? l10n.reviewRoleDriver
        : l10n.reviewRolePassenger;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final pendingAsync = ref.watch(pendingReviewsControllerProvider(rideId));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              header: true,
              child: Text(
                l10n.pendingReviewsTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 16),
            pendingAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CircularProgressIndicator(),
              ),
              error: (error, _) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  l10n.pendingReviewsLoadError,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              data: (targets) {
                if (targets.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(l10n.noPendingReviews),
                  );
                }
                return Column(
                  children: targets.map((target) {
                    final roleLabel = _roleLabel(l10n, target.role);
                    return Card(
                      key: Key('pending_review_${target.userId}'),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    target.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    roleLabel,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              fit: FlexFit.loose,
                              child: ElevatedButton(
                                key: Key(
                                    'pending_review_button_${target.userId}'),
                                onPressed: () =>
                                    _openReviewForm(context, target),
                                child: Text(l10n.rateAction),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 8),
            TextButton(
              key: const Key('pending_reviews_close_button'),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.closeAction),
            ),
          ],
        ),
      ),
    );
  }
}