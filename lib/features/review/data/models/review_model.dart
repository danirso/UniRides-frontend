import '../../domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.id,
    required super.rideId,
    required super.reviewerId,
    required super.revieweeId,
    required super.rating,
    super.comment,
    required super.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'].toString(),
      rideId: json['ride_id'].toString(),
      reviewerId: json['reviewer_id'].toString(),
      revieweeId: json['reviewee_id'].toString(),
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
