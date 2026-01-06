import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import 'sign_up_params.dart';

class UserSignUp {
  final AuthRepository repository;

  UserSignUp(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required SignUpParams params,
  }) async {
    return await repository.signUpWithEmailPassword(params: params);
  }
}
