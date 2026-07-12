import '../../domain/entities/review_with_reviewer_entity.dart';

class ReviewWithReviewerModel extends ReviewWithReviewerEntity {
  ReviewWithReviewerModel({
    required super.id,
    required super.rating,
    super.comment,
    required super.createdAt,
    required super.reviewerName,
  });

  factory ReviewWithReviewerModel.fromJson(Map<String, dynamic> json) {
    return ReviewWithReviewerModel(
      id: json['id'].toString(),
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
      reviewerName: json['reviewer_name'],
    );
  }
}
