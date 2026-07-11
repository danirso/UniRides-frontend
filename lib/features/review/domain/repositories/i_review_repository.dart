import '../entities/review_entity.dart';
import '../entities/pending_review_target_entity.dart';
import '../entities/review_with_reviewer_entity.dart';

abstract class IReviewRepository {
  /// Cria uma avaliação para [revieweeId] dentro da carona [rideId].
  /// Lança [DuplicateReviewException] (core/errors/review_exceptions.dart)
  /// se o par (ride, reviewer, reviewee) já tiver sido avaliado.
  Future<ReviewEntity> createReview({
    required String rideId,
    required String revieweeId,
    required int rating,
    String? comment,
  });

  /// Lista quem o usuário atual ainda pode avaliar nessa carona.
  Future<List<PendingReviewTargetEntity>> getPendingReviews(String rideId);

  /// Últimas avaliações recebidas por [userId] (default 5, max 50 no backend).
  Future<List<ReviewWithReviewerEntity>> getUserReviews(
    String userId, {
    int limit = 5,
  });
}
