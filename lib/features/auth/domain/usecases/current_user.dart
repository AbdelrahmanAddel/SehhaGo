import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class CurrentUser {
  final AuthRepository repository;

  CurrentUser(this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.getCurrentUser();
  }
}
