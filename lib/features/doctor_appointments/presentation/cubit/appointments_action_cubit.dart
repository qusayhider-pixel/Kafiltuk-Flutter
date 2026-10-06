import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiltuk/features/doctor_schedule/data/models/patient_appointment_model.dart';

part 'appointments_action_state.dart';

class AppointmentsActionCubit extends Cubit<AppointmentsActionState> {
  AppointmentsActionCubit() : super(AppointmentsActionState.initial()) {
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    emit(state.copyWith(loadStatus: AppointmentsLoadStatus.loading));
    await Future.delayed(const Duration(milliseconds: 600));
    emit(
      state.copyWith(
        loadStatus: AppointmentsLoadStatus.loaded,
        allAppointments: List.of(dummyPatientAppointments),
      ),
    );
  }

  void selectTab(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }

  Future<void> acceptAppointment(String id) async {
    emit(state.copyWith(processingId: id));
    await Future.delayed(const Duration(milliseconds: 900));

    final updatedList = state.allAppointments.map((appointment) {
      if (appointment.id == id) {
        return appointment.copyWith(status: PatientAppointmentStatus.upcoming);
      }
      return appointment;
    }).toList();

    emit(
      state.copyWith(
        allAppointments: updatedList,
        clearProcessingId: true,
      ),
    );
  }

  Future<void> rejectAppointment(String id) async {
    emit(state.copyWith(processingId: id));
    await Future.delayed(const Duration(milliseconds: 900));

    final updatedList = state.allAppointments.map((appointment) {
      if (appointment.id == id) {
        return appointment.copyWith(
          status: PatientAppointmentStatus.cancelled,
        );
      }
      return appointment;
    }).toList();

    emit(
      state.copyWith(
        allAppointments: updatedList,
        clearProcessingId: true,
      ),
    );
  }
}