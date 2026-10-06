enum PatientAppointmentStatus { pending, upcoming, completed, cancelled }

class PatientAppointmentInfo {
  final String id;
  final String patientName;
  final int patientAge;
  final String patientGender;
  final String patientImageUrl;
  final String reason;
  final DateTime dateTime;
  final int consultationFee;
  final PatientAppointmentStatus status;

  const PatientAppointmentInfo({
    required this.id,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.patientImageUrl,
    required this.reason,
    required this.dateTime,
    required this.consultationFee,
    required this.status,
  });

  PatientAppointmentInfo copyWith({PatientAppointmentStatus? status}) {
    return PatientAppointmentInfo(
      id: id,
      patientName: patientName,
      patientAge: patientAge,
      patientGender: patientGender,
      patientImageUrl: patientImageUrl,
      reason: reason,
      dateTime: dateTime,
      consultationFee: consultationFee,
      status: status ?? this.status,
    );
  }
}

final DateTime _now = DateTime.now();

final List<PatientAppointmentInfo> dummyPatientAppointments = [
  PatientAppointmentInfo(
    id: 'pa_1',
    patientName: 'Ali Raza',
    patientAge: 34,
    patientGender: 'Male',
    patientImageUrl: 'https://i.pravatar.cc/150?img=12',
    reason: 'Chest pain and shortness of breath',
    dateTime: DateTime(_now.year, _now.month, _now.day, 11, 0),
    consultationFee: 2500,
    status: PatientAppointmentStatus.pending,
  ),
  PatientAppointmentInfo(
    id: 'pa_2',
    patientName: 'Maria Fernandez',
    patientAge: 27,
    patientGender: 'Female',
    patientImageUrl: 'https://i.pravatar.cc/150?img=47',
    reason: 'Routine cardiac checkup',
    dateTime: DateTime(_now.year, _now.month, _now.day, 14, 30),
    consultationFee: 2500,
    status: PatientAppointmentStatus.pending,
  ),
  PatientAppointmentInfo(
    id: 'pa_3',
    patientName: 'Omar Siddiqui',
    patientAge: 58,
    patientGender: 'Male',
    patientImageUrl: 'https://i.pravatar.cc/150?img=33',
    reason: 'Follow-up on blood pressure medication',
    dateTime: DateTime(_now.year, _now.month, _now.day, 16, 0),
    consultationFee: 2500,
    status: PatientAppointmentStatus.upcoming,
  ),
  PatientAppointmentInfo(
    id: 'pa_4',
    patientName: 'Sana Tariq',
    patientAge: 41,
    patientGender: 'Female',
    patientImageUrl: 'https://i.pravatar.cc/150?img=25',
    reason: 'Irregular heartbeat evaluation',
    dateTime: _now.add(const Duration(days: 1, hours: 2)),
    consultationFee: 2500,
    status: PatientAppointmentStatus.upcoming,
  ),
  PatientAppointmentInfo(
    id: 'pa_5',
    patientName: 'David Chen',
    patientAge: 49,
    patientGender: 'Male',
    patientImageUrl: 'https://i.pravatar.cc/150?img=8',
    reason: 'Post-surgery cardiac review',
    dateTime: _now.subtract(const Duration(days: 4)),
    consultationFee: 2500,
    status: PatientAppointmentStatus.completed,
  ),
  PatientAppointmentInfo(
    id: 'pa_6',
    patientName: 'Fatima Noor',
    patientAge: 31,
    patientGender: 'Female',
    patientImageUrl: 'https://i.pravatar.cc/150?img=29',
    reason: 'General consultation',
    dateTime: _now.subtract(const Duration(days: 9)),
    consultationFee: 2500,
    status: PatientAppointmentStatus.completed,
  ),
  PatientAppointmentInfo(
    id: 'pa_7',
    patientName: 'Hassan Iqbal',
    patientAge: 63,
    patientGender: 'Male',
    patientImageUrl: 'https://i.pravatar.cc/150?img=51',
    reason: 'Chest discomfort',
    dateTime: _now.subtract(const Duration(days: 2)),
    consultationFee: 2500,
    status: PatientAppointmentStatus.cancelled,
  ),
];