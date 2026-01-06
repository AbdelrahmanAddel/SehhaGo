import 'package:flutter/material.dart';
import 'package:sehhago/features/auth/data/models/user_model.dart';
import 'package:sehhago/features/auth/domain/entities/user_entity.dart';

class FilterDoctorUseCase {
  List<UserEntity> call({
    required List<UserEntity> doctors,
    String? query,
    String? category,
    TimeOfDay? time,
  }) {
    var filtered = doctors;

    // 1. Search query
    if (query != null && query.isNotEmpty) {
      final q = query.toLowerCase();
      filtered = filtered
          .where(
            (d) =>
                d.firstName.toLowerCase().contains(q) ||
                d.lastName.toLowerCase().contains(q),
          )
          .toList();
    }

    // 2. Category filter
    if (category != null && category.isNotEmpty) {
      final c = category.toLowerCase();
      filtered = filtered
          .where(
            (d) =>
                d.specialization != null &&
                d.specialization!.toLowerCase() == c,
          )
          .toList();
    }

    // 3. Time filter using TimeOfDay
    if (time != null) {
      final t = time.hour + time.minute / 60.0;
      filtered = filtered.where((d) {
        TimeOfDay? start = (d is UserModel) ? d.startTimeOfDay : null;
        TimeOfDay? end = (d is UserModel) ? d.endTimeOfDay : null;

        if (start == null || end == null) return false;

        final startDouble = start.hour + start.minute / 60.0;
        final endDouble = end.hour + end.minute / 60.0;

        return t >= startDouble && t <= endDouble;
      }).toList();
    }

    return filtered;
  }
}
