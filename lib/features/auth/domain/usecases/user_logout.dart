import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class UserLogout {
  final AuthRepository repository;

  UserLogout(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}
