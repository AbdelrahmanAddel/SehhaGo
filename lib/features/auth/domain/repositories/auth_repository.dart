import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../usecases/sign_up_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required SignUpParams params,
  });

  Future<Either<Failure, UserEntity>> signInWithGoogle();

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserEntity>> getCurrentUser();
}
