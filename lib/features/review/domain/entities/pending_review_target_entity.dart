enum ReviewTargetRole { driver, passenger }

extension ReviewTargetRoleX on ReviewTargetRole {
  static ReviewTargetRole fromJson(String value) {
    return value == 'driver' ? ReviewTargetRole.driver : ReviewTargetRole.passenger;
  }
}

class PendingReviewTargetEntity {
  final String userId;
  final String name;
  final ReviewTargetRole role;

  const PendingReviewTargetEntity({
    required this.userId,
    required this.name,
    required this.role,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingReviewTargetEntity && other.userId == userId;

  @override
  int get hashCode => userId.hashCode;
}
