import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:sehhago/features/auth/data/datasources/auth_firebase_remote_data_source.dart';
import 'package:sehhago/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sehhago/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sehhago/features/auth/domain/repositories/auth_repository.dart';
import 'package:sehhago/features/auth/domain/usecases/current_user.dart';
import 'package:sehhago/features/auth/domain/usecases/user_login.dart';
import 'package:sehhago/features/auth/domain/usecases/user_logout.dart';
import 'package:sehhago/features/auth/domain/usecases/user_sign_up.dart';
import 'package:sehhago/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sehhago/core/network/network_info.dart';
import 'package:sehhago/features/search/data/datasources/search_remote_datasource.dart';
import 'package:sehhago/features/search/data/repositories/search_repository_impl.dart';
import 'package:sehhago/features/search/domain/repositories/search_repository.dart';
import 'package:sehhago/features/search/domain/usecases/filter_doctor_usecase.dart';
import 'package:sehhago/features/search/domain/usecases/get_all_doctors_usecase.dart';
import 'package:sehhago/features/search/presentation/bloc/search_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  _initCore();

  // Features - Auth
  _initAuth();

  // Features - Search
  _initSearch();
}

void _initCore() {
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => Connectivity());
  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(serviceLocator()),
  );
}

void _initSearch() {
  // Datasources
  serviceLocator.registerFactory<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(firestore: serviceLocator()),
  );

  // Repository
  serviceLocator.registerFactory<SearchRepository>(
    () => SearchRepositoryImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // UseCases
  serviceLocator.registerFactory(() => GetAllDoctorsUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => FilterDoctorUseCase());

  // Blocs
  serviceLocator.registerFactory(
    () => SearchBloc(
      getAllDoctorsUseCase: serviceLocator(),
      filterDoctorUseCase: serviceLocator(),
    ),
  );
}

void _initAuth() {
  // Datasources
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthFirebaseRemoteDataSource(
      firebaseAuth: serviceLocator(),
      firestore: serviceLocator(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  // UseCases
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogout(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  // Blocs
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      userLogout: serviceLocator(),
      currentUser: serviceLocator(),
    ),
  );
}
