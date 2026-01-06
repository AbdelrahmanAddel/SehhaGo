import 'package:flutter/material.dart';

import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/enums/user_role.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final TimeOfDay? startTimeOfDay;
  final TimeOfDay? endTimeOfDay;

  const UserModel({
    required super.uid,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.role,
    super.imageUrl,
    super.specialization,
    super.startTime,
    super.endTime,
    this.startTimeOfDay,
    this.endTimeOfDay,
  });

  /// Factory constructor from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    TimeOfDay? parseTimeOfDay(String? timeStr) {
      if (timeStr == null || timeStr.isEmpty) return null;
      final parts = timeStr.split(':');
      if (parts.length != 2) return null;
      try {
        return TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      } catch (_) {
        return null;
      }
    }

    final start = parseTimeOfDay(json[FirebaseConstants.startTime] as String?);
    final end = parseTimeOfDay(json[FirebaseConstants.endTime] as String?);

    return UserModel(
      uid: json[FirebaseConstants.uid] ?? '',
      email: json[FirebaseConstants.email] ?? '',
      firstName: json[FirebaseConstants.firstName] ?? '',
      lastName: json[FirebaseConstants.lastName] ?? '',
      phoneNumber: json[FirebaseConstants.phoneNumber] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json[FirebaseConstants.role]}',
        orElse: () => UserRole.patient,
      ),
      imageUrl: json[FirebaseConstants.imageUrl] as String?,
      specialization: json[FirebaseConstants.specialization] as String?,
      startTime: json[FirebaseConstants.startTime] as String?,
      endTime: json[FirebaseConstants.endTime] as String?,
      startTimeOfDay: start,
      endTimeOfDay: end,
    );
  }

  /// Convert back to JSON
  Map<String, dynamic> toJson() {
    return {
      FirebaseConstants.uid: uid,
      FirebaseConstants.email: email,
      FirebaseConstants.firstName: firstName,
      FirebaseConstants.lastName: lastName,
      FirebaseConstants.phoneNumber: phoneNumber,
      FirebaseConstants.role: role.name,
      FirebaseConstants.imageUrl: imageUrl,
      FirebaseConstants.specialization: specialization,
      FirebaseConstants.startTime: startTime,
      FirebaseConstants.endTime: endTime,
    };
  }

  /// Create UserModel from UserEntity
  factory UserModel.fromEntity(UserEntity entity) {
    TimeOfDay? parseTime(String? timeStr) {
      if (timeStr == null || timeStr.isEmpty) return null;
      final parts = timeStr.split(':');
      if (parts.length != 2) return null;
      try {
        return TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      } catch (_) {
        return null;
      }
    }

    return UserModel(
      uid: entity.uid,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      role: entity.role,
      imageUrl: entity.imageUrl,
      specialization: entity.specialization,
      startTime: entity.startTime,
      endTime: entity.endTime,
      startTimeOfDay: parseTime(entity.startTime),
      endTimeOfDay: parseTime(entity.endTime),
    );
  }
}
