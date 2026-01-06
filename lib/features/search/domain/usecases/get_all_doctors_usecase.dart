import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../repositories/search_repository.dart';

class GetAllDoctorsUseCase {
  final SearchRepository repository;

  GetAllDoctorsUseCase(this.repository);

  Future<Either<Failure, List<UserEntity>>> call() {
    return repository.getAllDoctors();
  }
}
