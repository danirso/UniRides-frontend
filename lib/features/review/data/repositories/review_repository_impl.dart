import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tcc_caronas_frontend/core/network/dio_client.dart';
import 'package:tcc_caronas_frontend/core/errors/review_exceptions.dart';
import '../models/review_model.dart';
import '../models/pending_review_target_model.dart';
import '../models/review_with_reviewer_model.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/entities/pending_review_target_entity.dart';
import '../../domain/entities/review_with_reviewer_entity.dart';
import '../../domain/repositories/i_review_repository.dart';

class ReviewRepositoryImpl implements IReviewRepository {
  final DioClient _client;

  ReviewRepositoryImpl(this._client);

  @override
  Future<ReviewEntity> createReview({
    required String rideId,
    required String revieweeId,
    required int rating,
    String? comment,
  }) async {
    try {
      final response = await _client.instance.post(
        '/rides/$rideId/reviews',
        data: {
          'reviewee_id': revieweeId,
          'rating': rating,
          'comment': comment,
        },
      );
      return ReviewModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Erro ao criar avaliação: ${e.response?.data}');
      if (e.response?.statusCode == 400 &&
          e.response?.data.toString().contains('DUPLICATE_REVIEW') == true) {
        throw const DuplicateReviewException();
      }
      throw Exception('Erro ao enviar avaliação');
    }
  }

  @override
  Future<List<PendingReviewTargetEntity>> getPendingReviews(
    String rideId,
  ) async {
    try {
      final response = await _client.instance.get(
        '/rides/$rideId/reviews/pending',
      );
      final List data = response.data;
      return data
          .map((json) => PendingReviewTargetModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      debugPrint('Erro ao carregar avaliações pendentes: ${e.response?.data}');
      throw Exception('Erro ao carregar avaliações pendentes');
    }
  }

  @override
  Future<List<ReviewWithReviewerEntity>> getUserReviews(
    String userId, {
    int limit = 5,
  }) async {
    try {
      final response = await _client.instance.get(
        '/users/$userId/reviews',
        queryParameters: {'limit': limit},
      );
      final List data = response.data;
      return data
          .map((json) => ReviewWithReviewerModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      debugPrint('Erro ao carregar avaliações do usuário: ${e.response?.data}');
      throw Exception('Erro ao carregar avaliações do usuário');
    }
  }
}
