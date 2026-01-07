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

<<<<<<< HEAD
    // Search query filter
    if (query != null && query.trim().isNotEmpty) {
      final q = query.trim().toLowerCase();
=======
    // 1. Search query
    if (query != null && query.isNotEmpty) {
      final q = query.toLowerCase();
>>>>>>> 88d6510c5558a6370660184c326fc42f9a4ba37c
      filtered = filtered
          .where(
            (d) =>
                d.firstName.toLowerCase().contains(q) ||
<<<<<<< HEAD
                d.lastName.toLowerCase().contains(q) ||
                (d.specialization?.toLowerCase().contains(q) ?? false),
=======
                d.lastName.toLowerCase().contains(q),
>>>>>>> 88d6510c5558a6370660184c326fc42f9a4ba37c
          )
          .toList();
    }

<<<<<<< HEAD
    // Category filter
    if (category != null && category.trim().isNotEmpty) {
      final c = category.trim().toLowerCase();
      filtered = filtered
          .where((d) => d.specialization?.trim().toLowerCase() == c)
          .toList();
    }

    // Time availability filter
=======
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
>>>>>>> 88d6510c5558a6370660184c326fc42f9a4ba37c
    if (time != null) {
      final t = time.hour + time.minute / 60.0;

      filtered = filtered.where((d) {
<<<<<<< HEAD
        if (d.startTime == null || d.endTime == null) return false;
        if (d.startTime!.isEmpty || d.endTime!.isEmpty) return false;

        final start = parseTime(d.startTime!.trim());
        final end = parseTime(d.endTime!.trim());

        // same-day shift
        if (start <= end) {
          return t >= start && t <= end;
        }

        // overnight shift (e.g. 10 PM -> 2 AM)
        return t >= start || t <= end;
=======
        TimeOfDay? start = (d is UserModel) ? d.startTimeOfDay : null;
        TimeOfDay? end = (d is UserModel) ? d.endTimeOfDay : null;

        if (start == null || end == null) return false;

        final startDouble = start.hour + start.minute / 60.0;
        final endDouble = end.hour + end.minute / 60.0;

        return t >= startDouble && t <= endDouble;
>>>>>>> 88d6510c5558a6370660184c326fc42f9a4ba37c
      }).toList();
    }

    return filtered;
  }
<<<<<<< HEAD

  double parseTime(String timeStr) {
    try {
      // Handle both HH:mm and HH.mm formats
      final normalized = timeStr.replaceAll('.', ':');
      final parts = normalized.split(':');
      if (parts.length < 2) return 0.0;

      final hourStr = parts[0].replaceAll(RegExp(r'\D'), '');
      final minuteStr = parts[1].replaceAll(RegExp(r'\D'), '');

      if (hourStr.isEmpty || minuteStr.isEmpty) return 0.0;

      int hour = int.parse(hourStr);
      final int minute = int.parse(minuteStr);

      if (normalized.toLowerCase().contains('pm') && hour < 12) {
        hour += 12;
      } else if (normalized.toLowerCase().contains('am') && hour == 12) {
        hour = 0;
      }

      return hour + minute / 60.0;
    } catch (e) {
      return 0.0;
    }
  }
=======
>>>>>>> 88d6510c5558a6370660184c326fc42f9a4ba37c
}
