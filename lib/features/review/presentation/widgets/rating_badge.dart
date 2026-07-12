import 'package:flutter/material.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import 'user_reviews_list_widget.dart';

class RatingBadge extends StatelessWidget {
  final double ratingAvg;
  final int ratingCount;
  final String? userId;

  const RatingBadge({
    super.key,
    required this.ratingAvg,
    required this.ratingCount,
    this.userId,
  });

  void _showReviews(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    l10n.userReviewsModalTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 16),
                UserReviewsListWidget(userId: userId!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final Widget content = ratingCount == 0
        ? Semantics(
            label: l10n.noRatingsYet,
            child: Text(
              '—',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          )
        : Semantics(
            label: l10n.ratingSemanticLabel(
              ratingAvg.toStringAsFixed(1),
              ratingCount,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  ratingAvg.toStringAsFixed(1),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  '($ratingCount)',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          );

    if (userId == null) return content;

    return Semantics(
      button: true,
      label: l10n.userReviewsModalTitle,
      child: InkWell(
        key: Key('rating_badge_$userId'),
        borderRadius: BorderRadius.circular(8),
        onTap: () => _showReviews(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: content,
        ),
      ),
    );
  }
}
