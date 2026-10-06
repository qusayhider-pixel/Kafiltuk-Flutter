import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kafiltuk/features/doctor_schedule/data/models/patient_appointment_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DoctorAppointmentCard extends StatelessWidget {
  final PatientAppointmentInfo appointment;

  const DoctorAppointmentCard({super.key, required this.appointment});

  Color get _statusColor {
    switch (appointment.status) {
      case PatientAppointmentStatus.upcoming:
        return AppColors.primary;
      case PatientAppointmentStatus.completed:
        return AppColors.success;
      case PatientAppointmentStatus.cancelled:
        return Colors.redAccent;
      case PatientAppointmentStatus.pending:
        return const Color(0xFFB8860B);
    }
  }

  String get _statusLabel {
    switch (appointment.status) {
      case PatientAppointmentStatus.upcoming:
        return 'Upcoming';
      case PatientAppointmentStatus.completed:
        return 'Completed';
      case PatientAppointmentStatus.cancelled:
        return 'Cancelled';
      case PatientAppointmentStatus.pending:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              appointment.patientImageUrl,
              width: 58,
              height: 58,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 58,
                  height: 58,
                  color: AppColors.generalCategory,
                  child: const Icon(Icons.person, color: Colors.white),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        appointment.patientName,
                        style: AppTextStyles.h3,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _statusLabel,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  appointment.reason,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 13,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat('EEE, d MMM yyyy')
                          .format(appointment.dateTime),
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.access_time_rounded,
                      size: 13,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat('h:mm a').format(appointment.dateTime),
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
