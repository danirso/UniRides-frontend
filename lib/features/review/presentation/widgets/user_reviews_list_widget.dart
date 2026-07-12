import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/core/theme/app_theme.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../controllers/user_reviews_controller.dart';

class UserReviewsListWidget extends ConsumerWidget {
  final String userId;

  const UserReviewsListWidget({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final reviewsAsync = ref.watch(userReviewsControllerProvider(userId));

    return reviewsAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Text(
        l10n.userReviewsLoadError,
        style: const TextStyle(color: Colors.red),
      ),
      data: (reviews) {
        if (reviews.isEmpty) {
          return Text(l10n.noUserReviewsYet);
        }
        return Column(
          children: reviews.map((review) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      label: l10n.reviewByLabel(
                          review.reviewerName, review.rating),
                      child: Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < review.rating
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                size: 16,
                                color: AppTheme.sandYellow,
                              );
                            }),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            review.reviewerName,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    if (review.comment != null &&
                        review.comment!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(review.comment!),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}