import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.isEmailVerified,
    required super.canDrive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      isEmailVerified: json['is_email_verified'] ?? false,
      canDrive: json['can_drive'] ?? false,
    );
  }
}