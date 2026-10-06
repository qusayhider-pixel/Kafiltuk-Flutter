class TimeSlot {
  final String startTime;
  final String endTime;

  const TimeSlot({required this.startTime, required this.endTime});

  String get label => '$startTime - $endTime';
}