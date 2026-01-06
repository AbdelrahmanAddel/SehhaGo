import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/enums/user_role.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.role,
    super.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json[FirebaseConstants.uid] ?? '',
      email: json[FirebaseConstants.email] ?? '',
      firstName: json[FirebaseConstants.firstName] ?? '',
      lastName: json[FirebaseConstants.lastName] ?? '',
      phoneNumber: json[FirebaseConstants.phoneNumber] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json[FirebaseConstants.role]}',
        orElse: () => UserRole.patient,
      ),
      imageUrl: json[FirebaseConstants.imageUrl] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FirebaseConstants.uid: uid,
      FirebaseConstants.email: email,
      FirebaseConstants.firstName: firstName,
      FirebaseConstants.lastName: lastName,
      FirebaseConstants.phoneNumber: phoneNumber,
      FirebaseConstants.role: role.name,
      FirebaseConstants.imageUrl: imageUrl,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      role: entity.role,
      imageUrl: entity.imageUrl,
    );
  }
}
