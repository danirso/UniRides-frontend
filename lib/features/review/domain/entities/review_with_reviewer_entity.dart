class ReviewWithReviewerEntity {
  final String id;
  final int rating;
  final String? comment;
  final DateTime createdAt;
  final String reviewerName;

  const ReviewWithReviewerEntity({
    required this.id,
    required this.rating,
    this.comment,
    required this.createdAt,
    required this.reviewerName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewWithReviewerEntity && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
