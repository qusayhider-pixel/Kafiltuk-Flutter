
import 'package:equatable/equatable.dart';

class DoctorBookingState extends Equatable {
  final List<DateTime> availableDates;
  final List<String> availableTimes;
  final int selectedDateIndex;
  final int selectedTimeIndex;
  final bool isBookingConfirmed;

  const DoctorBookingState({
    required this.availableDates,
    required this.availableTimes,
    required this.selectedDateIndex,
    required this.selectedTimeIndex,
    required this.isBookingConfirmed,
  });

  factory DoctorBookingState.initial() {
    final now = DateTime.now();
    return DoctorBookingState(
      availableDates: List.generate(5, (i) => now.add(Duration(days: i))),
      availableTimes: const [
        '09:00 AM',
        '10:30 AM',
        '12:00 PM',
        '02:30 PM',
        '04:00 PM',
        '06:30 PM',
      ],
      selectedDateIndex: 0,
      selectedTimeIndex: -1,
      isBookingConfirmed: false,
    );
  }

  DateTime get selectedDate => availableDates[selectedDateIndex];

  String? get selectedTime =>
      selectedTimeIndex == -1 ? null : availableTimes[selectedTimeIndex];

  bool get canBook => selectedTimeIndex != -1;

  DoctorBookingState copyWith({
    int? selectedDateIndex,
    int? selectedTimeIndex,
    bool? isBookingConfirmed,
  }) {
    return DoctorBookingState(
      availableDates: availableDates,
      availableTimes: availableTimes,
      selectedDateIndex: selectedDateIndex ?? this.selectedDateIndex,
      selectedTimeIndex: selectedTimeIndex ?? this.selectedTimeIndex,
      isBookingConfirmed: isBookingConfirmed ?? this.isBookingConfirmed,
    );
  }

  @override
  List<Object?> get props => [
        availableDates,
        availableTimes,
        selectedDateIndex,
        selectedTimeIndex,
        isBookingConfirmed,
      ];
}