import 'package:equatable/equatable.dart';
import '../../../../core/enums/user_role.dart';

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final UserRole role;
  final String? imageUrl;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.role,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
    email,
    password,
    firstName,
    lastName,
    phoneNumber,
    role,
    imageUrl,
  ];
}
