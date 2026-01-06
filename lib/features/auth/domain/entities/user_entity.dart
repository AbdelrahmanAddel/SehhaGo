import 'package:equatable/equatable.dart';
import '../../../../core/enums/user_role.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final UserRole role;
  final String? imageUrl;
  final String? specialization;
  final String? startTime;
  final String? endTime;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.role,
    this.imageUrl,
    this.specialization,
    this.startTime,
    this.endTime,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    firstName,
    lastName,
    phoneNumber,
    role,
    imageUrl,
    specialization,
    startTime,
    endTime,
  ];
}
