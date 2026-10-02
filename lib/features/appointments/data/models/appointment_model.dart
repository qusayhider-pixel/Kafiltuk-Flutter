import '../../../doctor_booking/data/models/doctor_model.dart';

enum AppointmentStatus { upcoming, completed, cancelled }

class Appointment {
  final String id;
  final Doctor doctor;
  final DateTime dateTime;
  final AppointmentStatus status;

  const Appointment({
    required this.id,
    required this.doctor,
    required this.dateTime,
    required this.status,
  });
}

final List<Appointment> dummyAppointments = [
  Appointment(
    id: 'apt_1',
    doctor: dummyDoctors[0],
    dateTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
    status: AppointmentStatus.upcoming,
  ),
  Appointment(
    id: 'apt_2',
    doctor: dummyDoctors[1],
    dateTime: DateTime.now().add(const Duration(days: 3)),
    status: AppointmentStatus.upcoming,
  ),
  Appointment(
    id: 'apt_3',
    doctor: dummyDoctors[2],
    dateTime: DateTime.now().subtract(const Duration(days: 5)),
    status: AppointmentStatus.completed,
  ),
  Appointment(
    id: 'apt_4',
    doctor: dummyDoctors[0],
    dateTime: DateTime.now().subtract(const Duration(days: 12)),
    status: AppointmentStatus.completed,
  ),
  Appointment(
    id: 'apt_5',
    doctor: dummyDoctors[1],
    dateTime: DateTime.now().subtract(const Duration(days: 2)),
    status: AppointmentStatus.cancelled,
  ),
];