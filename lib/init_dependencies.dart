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

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);

  // Features - Auth
  _initAuth();
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
