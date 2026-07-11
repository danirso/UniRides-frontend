import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/review_with_reviewer_entity.dart';
import '../../data/repositories/review_repository_provider.dart';

class UserReviewsController
    extends Notifier<AsyncValue<List<ReviewWithReviewerEntity>>> {
  UserReviewsController(this.userId);

  final String userId;

  @override
  AsyncValue<List<ReviewWithReviewerEntity>> build() {
    _fetch();
    return const AsyncValue.loading();
  }

  Future<void> _fetch({int limit = 5}) async {
    try {
      final repository = ref.read(reviewRepositoryProvider);
      final reviews = await repository.getUserReviews(userId, limit: limit);
      state = AsyncValue.data(reviews);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _fetch();
  }
}

final userReviewsControllerProvider = NotifierProvider.family<
    UserReviewsController,
    AsyncValue<List<ReviewWithReviewerEntity>>,
    String>(UserReviewsController.new);