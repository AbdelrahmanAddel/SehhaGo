import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sehhago/core/constants/firebase_constants.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/sign_up_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthFirebaseRemoteDataSource implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthFirebaseRemoteDataSource({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw const ServerFailure('User is not logged in');
    }

    final userData = await firestore
        .collection(FirebaseConstants.usersCollection)
        .doc(currentUser.uid)
        .get();

    if (!userData.exists) {
      throw const ServerFailure('User data not found');
    }

    return UserModel.fromJson(userData.data()!);
  }

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const ServerFailure('User is null');
      }

      final userData = await firestore
          .collection(FirebaseConstants.usersCollection)
          .doc(userCredential.user!.uid)
          .get();

      if (!userData.exists) {
        throw const ServerFailure('User data not found');
      }

      return UserModel.fromJson(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown error occurred');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required SignUpParams params,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      if (userCredential.user == null) {
        throw const ServerFailure('User is null');
      }

      final user = UserModel(
        uid: userCredential.user!.uid,
        email: params.email,
        firstName: params.firstName,
        lastName: params.lastName,
        phoneNumber: params.phoneNumber,
        role: params.role,
        imageUrl: params.imageUrl,
      );

      await _saveUserData(user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown error occurred');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future<void> _saveUserData(UserModel user) async {
    await firestore
        .collection(FirebaseConstants.usersCollection)
        .doc(user.uid)
        .set(user.toJson());
  }
}
