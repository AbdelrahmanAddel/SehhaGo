import 'package:flutter/material.dart';
import 'package:sehhago/features/auth/domain/entities/user_entity.dart';

class FilterDoctorUseCase {
  List<UserEntity> call({
    required List<UserEntity> doctors,
    String? query,
    String? category,
    TimeOfDay? time,
  }) {
    var filtered = doctors;
    if (query != null && query.isNotEmpty) {
      filtered = filtered
          .where(
            (d) =>
                d.firstName.toLowerCase().contains(query.toLowerCase()) ||
                d.lastName.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    if (category != null && category.isNotEmpty) {
      filtered = filtered
          .where(
            (d) => d.specialization?.toLowerCase() == category.toLowerCase(),
          )
          .toList();
    }
    if (time != null) {
      final t = time.hour + time.minute / 60.0;
      filtered = filtered.where((d) {
        if (d.startTime == null || d.endTime == null) return false;
        final start = parseTime(d.startTime!);
        final end = parseTime(d.endTime!);
        return t >= start && t <= end;
      }).toList();
    }
    return filtered;
  }

  double parseTime(String timeStr) {
    final parts = timeStr.split(':');
    return int.parse(parts[0]) + int.parse(parts[1]) / 60.0;
  }
}
