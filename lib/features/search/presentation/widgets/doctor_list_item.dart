import 'package:flutter/material.dart';
import '../../../auth/domain/entities/user_entity.dart';

class DoctorListItem extends StatelessWidget {
  final UserEntity doctor;

  const DoctorListItem({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage:
              doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty
              ? NetworkImage(doctor.imageUrl!)
              : null,
          child: doctor.imageUrl == null || doctor.imageUrl!.isEmpty
              ? Text(
                  doctor.firstName.isNotEmpty
                      ? doctor.firstName[0].toUpperCase()
                      : 'D',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        title: Text(
          'Dr. ${doctor.firstName} ${doctor.lastName}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (doctor.specialization != null)
              Text(
                doctor.specialization!,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(height: 4),
            if (doctor.startTime != null && doctor.endTime != null)
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${doctor.startTime} - ${doctor.endTime}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
          ],
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
