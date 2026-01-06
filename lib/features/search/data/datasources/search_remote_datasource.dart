import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../auth/data/models/user_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<UserModel>> getAllDoctors();
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final FirebaseFirestore firestore;

  SearchRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<UserModel>> getAllDoctors() async {
    try {
      final querySnapshot = await firestore
          .collection(FirebaseConstants.usersCollection)
          .where(
            FirebaseConstants.role,
            isEqualTo: FirebaseConstants.doctorRole,
          )
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }
}
