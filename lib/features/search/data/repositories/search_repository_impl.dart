import 'package:dartz/dartz.dart';
import 'package:sehhago/core/constants/error_messages.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> getAllDoctors() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDoctors = await remoteDataSource.getAllDoctors();
        return Right(remoteDoctors);
      } on ServerException {
        return Left(ServerFailure(ErrorMessages.serverError));
      }
    } else {
      return Left(NetworkFailure(ErrorMessages.networkError));
    }
  }
}
