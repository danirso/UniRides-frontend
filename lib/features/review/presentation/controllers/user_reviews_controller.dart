import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/review_with_reviewer_entity.dart';
import '../../data/repositories/review_repository_provider.dart';

class UserReviewsController
    extends Notifier<AsyncValue<List<ReviewWithReviewerEntity>>> {
  UserReviewsController(this.userId);

  final String userId;

  @override
  AsyncValue<List<ReviewWithReviewerEntity>> build() {
    _load();
    return const AsyncValue.loading();
  }

  Future<void> _load({int limit = 5}) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(reviewRepositoryProvider);
      final reviews = await repository.getUserReviews(userId, limit: limit);
      state = AsyncValue.data(reviews);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _load();
}

final userReviewsControllerProvider =
    NotifierProvider.family<
      UserReviewsController,
      AsyncValue<List<ReviewWithReviewerEntity>>,
      String
    >(UserReviewsController.new);
