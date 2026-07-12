class UserEntity {
  final String id;
  final String name;
  final String email;
  final bool isEmailVerified;
  final bool canDrive;
  final double ratingAvg;
  final int ratingCount;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.isEmailVerified,
    required this.canDrive,
    this.ratingAvg = 0.0,
    this.ratingCount = 0,
  });
}
