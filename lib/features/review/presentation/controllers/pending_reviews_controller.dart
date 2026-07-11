import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/pending_review_target_entity.dart';
import '../../data/repositories/review_repository_provider.dart';

class PendingReviewsController
    extends Notifier<AsyncValue<List<PendingReviewTargetEntity>>> {
  PendingReviewsController(this.rideId);

  final String rideId;

  @override
  AsyncValue<List<PendingReviewTargetEntity>> build() {
    _fetch();
    return const AsyncValue.loading();
  }

  Future<void> _fetch() async {
    try {
      final repository = ref.read(reviewRepositoryProvider);
      final targets = await repository.getPendingReviews(rideId);
      state = AsyncValue.data(targets);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _fetch();
  }

  Future<void> submitReview({
    required String revieweeId,
    required int rating,
    String? comment,
  }) async {
    final repository = ref.read(reviewRepositoryProvider);
    await repository.createReview(
      rideId: rideId,
      revieweeId: revieweeId,
      rating: rating,
      comment: comment,
    );
    final current = state.value ?? [];
    state = AsyncValue.data(
      current.where((target) => target.userId != revieweeId).toList(),
    );
  }
}

final pendingReviewsControllerProvider = NotifierProvider.family<
    PendingReviewsController,
    AsyncValue<List<PendingReviewTargetEntity>>,
    String>(PendingReviewsController.new);