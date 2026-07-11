import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/core/theme/app_theme.dart';
import '../controllers/user_reviews_controller.dart';

class UserReviewsListWidget extends ConsumerWidget {
  final String userId;

  const UserReviewsListWidget({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(userReviewsControllerProvider(userId));

    return reviewsAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => const Text(
        'Erro ao carregar avaliações.',
        style: TextStyle(color: Colors.red),
      ),
      data: (reviews) {
        if (reviews.isEmpty) {
          return const Text('Ainda não há avaliações.');
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
                      label:
                          '${review.reviewerName} avaliou com ${review.rating} de 5 estrelas',
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
                            style: const TextStyle(fontWeight: FontWeight.w600),
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
