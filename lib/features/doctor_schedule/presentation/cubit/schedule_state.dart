part of 'schedule_cubit.dart';

class ScheduleState extends Equatable {
  final List<String> weekDays;
  final Set<int> activeDays;
  final int selectedDayIndex;
  final Map<int, List<TimeSlot>> slotsByDay;
  final String? errorMessage;

  const ScheduleState({
    required this.weekDays,
    required this.activeDays,
    required this.selectedDayIndex,
    required this.slotsByDay,
    this.errorMessage,
  });

  factory ScheduleState.initial() {
    return const ScheduleState(
      weekDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      activeDays: {0, 1, 2, 3, 4},
      selectedDayIndex: 0,
      slotsByDay: {
        0: [
          TimeSlot(startTime: '09:00 AM', endTime: '12:00 PM'),
          TimeSlot(startTime: '02:00 PM', endTime: '05:00 PM'),
        ],
        1: [
          TimeSlot(startTime: '09:00 AM', endTime: '12:00 PM'),
        ],
        2: [
          TimeSlot(startTime: '10:00 AM', endTime: '01:00 PM'),
          TimeSlot(startTime: '03:00 PM', endTime: '06:00 PM'),
        ],
      },
    );
  }

  List<TimeSlot> get selectedDaySlots => slotsByDay[selectedDayIndex] ?? [];

  bool get isSelectedDayActive => activeDays.contains(selectedDayIndex);

  ScheduleState copyWith({
    Set<int>? activeDays,
    int? selectedDayIndex,
    Map<int, List<TimeSlot>>? slotsByDay,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ScheduleState(
      weekDays: weekDays,
      activeDays: activeDays ?? this.activeDays,
      selectedDayIndex: selectedDayIndex ?? this.selectedDayIndex,
      slotsByDay: slotsByDay ?? this.slotsByDay,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props =>
      [weekDays, activeDays, selectedDayIndex, slotsByDay, errorMessage];
}