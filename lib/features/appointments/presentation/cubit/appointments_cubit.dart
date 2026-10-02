import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/appointment_model.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit() : super(AppointmentsState.initial()) {
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    emit(state.copyWith(loadStatus: AppointmentsLoadStatus.loading));
    await Future.delayed(const Duration(milliseconds: 600));
    emit(
      state.copyWith(
        loadStatus: AppointmentsLoadStatus.loaded,
        allAppointments: dummyAppointments,
      ),
    );
  }

  void selectTab(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }
}