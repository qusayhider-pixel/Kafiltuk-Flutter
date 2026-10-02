import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiltuk/features/doctor_booking/presentation/cubit/doctor_booking_state.dart';


class DoctorBookingCubit extends Cubit<DoctorBookingState> {
  DoctorBookingCubit() : super(DoctorBookingState.initial());

  void selectDate(int index) {
    emit(state.copyWith(selectedDateIndex: index, selectedTimeIndex: -1));
  }

  void selectTime(int index) {
    emit(state.copyWith(selectedTimeIndex: index));
  }

  void confirmBooking() {
    if (state.canBook) {
      emit(state.copyWith(isBookingConfirmed: true));
    }
  }
}