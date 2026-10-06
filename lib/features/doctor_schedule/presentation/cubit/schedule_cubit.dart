import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/time_slot_model.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit() : super(ScheduleState.initial());

  void selectDay(int index) {
    emit(state.copyWith(selectedDayIndex: index, clearError: true));
  }

  void toggleDayActive(int index) {
    final updated = Set<int>.from(state.activeDays);
    if (updated.contains(index)) {
      updated.remove(index);
    } else {
      updated.add(index);
    }
    emit(state.copyWith(activeDays: updated, clearError: true));
  }

  void addTimeSlot(String startTime, String endTime) {
    final currentSlots = List<TimeSlot>.from(state.selectedDaySlots);

    final alreadyExists = currentSlots.any(
      (slot) => slot.startTime == startTime && slot.endTime == endTime,
    );

    if (alreadyExists) {
      emit(state.copyWith(errorMessage: 'This slot has already been added'));
      return;
    }

    currentSlots.add(TimeSlot(startTime: startTime, endTime: endTime));
    currentSlots.sort((a, b) => a.startTime.compareTo(b.startTime));

    final updatedMap = Map<int, List<TimeSlot>>.from(state.slotsByDay);
    updatedMap[state.selectedDayIndex] = currentSlots;

    emit(state.copyWith(slotsByDay: updatedMap, clearError: true));
  }

  void removeTimeSlot(int slotIndex) {
    final currentSlots = List<TimeSlot>.from(state.selectedDaySlots);
    if (slotIndex < 0 || slotIndex >= currentSlots.length) return;

    currentSlots.removeAt(slotIndex);

    final updatedMap = Map<int, List<TimeSlot>>.from(state.slotsByDay);
    updatedMap[state.selectedDayIndex] = currentSlots;

    emit(state.copyWith(slotsByDay: updatedMap, clearError: true));
  }

  void clearError() {
    emit(state.copyWith(clearError: true));
  }
}