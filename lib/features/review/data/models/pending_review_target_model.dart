import '../../domain/entities/pending_review_target_entity.dart';

class PendingReviewTargetModel extends PendingReviewTargetEntity {
  PendingReviewTargetModel({
    required super.userId,
    required super.name,
    required super.role,
  });

  factory PendingReviewTargetModel.fromJson(Map<String, dynamic> json) {
    return PendingReviewTargetModel(
      userId: json['user_id'].toString(),
      name: json['name'],
      role: ReviewTargetRoleX.fromJson(json['role']),
    );
  }
}
