import '../models/user_model.dart';
import '../../domain/usecases/sign_up_params.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmailPassword({required SignUpParams params});

  Future<UserModel> signInWithGoogle();

  Future<void> signOut();

  Future<UserModel> getCurrentUser();
}
