part of 'appointments_cubit.dart';

enum AppointmentsLoadStatus { loading, loaded }

class AppointmentsState extends Equatable {
  final AppointmentsLoadStatus loadStatus;
  final List<Appointment> allAppointments;
  final int selectedTabIndex;

  const AppointmentsState({
    required this.loadStatus,
    required this.allAppointments,
    required this.selectedTabIndex,
  });

  factory AppointmentsState.initial() {
    return const AppointmentsState(
      loadStatus: AppointmentsLoadStatus.loading,
      allAppointments: [],
      selectedTabIndex: 0,
    );
  }

  static const List<AppointmentStatus> tabStatuses = [
    AppointmentStatus.upcoming,
    AppointmentStatus.completed,
    AppointmentStatus.cancelled,
  ];

  List<Appointment> get filteredAppointments {
    final targetStatus = tabStatuses[selectedTabIndex];
    return allAppointments
        .where((appointment) => appointment.status == targetStatus)
        .toList();
  }

  AppointmentsState copyWith({
    AppointmentsLoadStatus? loadStatus,
    List<Appointment>? allAppointments,
    int? selectedTabIndex,
  }) {
    return AppointmentsState(
      loadStatus: loadStatus ?? this.loadStatus,
      allAppointments: allAppointments ?? this.allAppointments,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object?> get props => [loadStatus, allAppointments, selectedTabIndex];
}