part of 'appointments_action_cubit.dart';

enum AppointmentsLoadStatus { loading, loaded }

class AppointmentsActionState extends Equatable {
  final AppointmentsLoadStatus loadStatus;
  final List<PatientAppointmentInfo> allAppointments;
  final int selectedTabIndex;
  final String? processingId;

  const AppointmentsActionState({
    required this.loadStatus,
    required this.allAppointments,
    required this.selectedTabIndex,
    this.processingId,
  });

  factory AppointmentsActionState.initial() {
    return const AppointmentsActionState(
      loadStatus: AppointmentsLoadStatus.loading,
      allAppointments: [],
      selectedTabIndex: 0,
    );
  }

  List<PatientAppointmentInfo> get pending => allAppointments
      .where((a) => a.status == PatientAppointmentStatus.pending)
      .toList();

  List<PatientAppointmentInfo> get upcoming => allAppointments
      .where((a) => a.status == PatientAppointmentStatus.upcoming)
      .toList();

  List<PatientAppointmentInfo> get history => allAppointments
      .where(
        (a) =>
            a.status == PatientAppointmentStatus.completed ||
            a.status == PatientAppointmentStatus.cancelled,
      )
      .toList()
    ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

  int get todaysAppointmentsCount {
    final now = DateTime.now();
    return allAppointments.where((a) {
      return a.status == PatientAppointmentStatus.upcoming &&
          a.dateTime.year == now.year &&
          a.dateTime.month == now.month &&
          a.dateTime.day == now.day;
    }).length;
  }

  List<PatientAppointmentInfo> get todaysPatients {
    final now = DateTime.now();
    final todays = allAppointments.where((a) {
      final isTodayOrPending =
          a.status == PatientAppointmentStatus.upcoming ||
              a.status == PatientAppointmentStatus.pending;
      return isTodayOrPending &&
          a.dateTime.year == now.year &&
          a.dateTime.month == now.month &&
          a.dateTime.day == now.day;
    }).toList();
    todays.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return todays;
  }

  AppointmentsActionState copyWith({
    AppointmentsLoadStatus? loadStatus,
    List<PatientAppointmentInfo>? allAppointments,
    int? selectedTabIndex,
    String? processingId,
    bool clearProcessingId = false,
  }) {
    return AppointmentsActionState(
      loadStatus: loadStatus ?? this.loadStatus,
      allAppointments: allAppointments ?? this.allAppointments,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      processingId:
          clearProcessingId ? null : (processingId ?? this.processingId),
    );
  }

  @override
  List<Object?> get props =>
      [loadStatus, allAppointments, selectedTabIndex, processingId];
}