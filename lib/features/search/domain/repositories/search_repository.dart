import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<UserEntity>>> getAllDoctors();
}
