class UserEntity {
  final String id;
  final String name;
  final String email;
  final bool isEmailVerified;
  final bool canDrive;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.isEmailVerified,
    required this.canDrive,
  });
}