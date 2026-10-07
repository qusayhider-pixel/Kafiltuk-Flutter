import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/schedule_cubit.dart';
import '../widgets/add_slot_sheet.dart';
import '../widgets/day_toggle_chip.dart';
import '../widgets/time_slot_card.dart';

class DoctorSchedulePage extends StatelessWidget {
  const DoctorSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScheduleCubit(),
      child: const _DoctorScheduleView(),
    );
  }
}

class _DoctorScheduleView extends StatelessWidget {
  const _DoctorScheduleView();

  void _openAddSlotSheet(BuildContext context) {
    final cubit = context.read<ScheduleCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) =>
          AddSlotSheet(onAdd: (start, end) => cubit.addTimeSlot(start, end)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<ScheduleCubit, ScheduleState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              context.read<ScheduleCubit>().clearError();
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('My Schedule', style: AppTextStyles.h1),
                      const SizedBox(height: 4),
                      const Text(
                        'Set your weekly availability for patients',
                        style: AppTextStyles.body,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 86,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.weekDays.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            return DayToggleChip(
                              label: state.weekDays[index],
                              isSelected: state.selectedDayIndex == index,
                              isActive: state.activeDays.contains(index),
                              onTap: () => context
                                  .read<ScheduleCubit>()
                                  .selectDay(index),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: state.isSelectedDayActive
                                    ? AppColors.success.withOpacity(0.1)
                                    : AppColors.divider,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    state.isSelectedDayActive
                                        ? Icons.check_circle_rounded
                                        : Icons.cancel_rounded,
                                    size: 18,
                                    color: state.isSelectedDayActive
                                        ? AppColors.success
                                        : AppColors.textMuted,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      state.isSelectedDayActive
                                          ? 'Available on ${state.weekDays[state.selectedDayIndex]}'
                                          : 'Marked unavailable',
                                      style: AppTextStyles.bodyBold.copyWith(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Switch(
                                    value: state.isSelectedDayActive,
                                    activeColor: AppColors.success,
                                    onChanged: (_) => context
                                        .read<ScheduleCubit>()
                                        .toggleDayActive(
                                          state.selectedDayIndex,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Time Slots', style: AppTextStyles.h3),
                          GestureDetector(
                            onTap: () => _openAddSlotSheet(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Add Slot',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
                Expanded(
                  child: state.selectedDaySlots.isEmpty
                      ? _buildEmptyState()
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          children: List.generate(
                            state.selectedDaySlots.length,
                            (index) => TimeSlotCard(
                              slot: state.selectedDaySlots[index],
                              onRemove: () => context
                                  .read<ScheduleCubit>()
                                  .removeTimeSlot(index),
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.schedule_rounded,
              size: 32,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          const Text('No time slots yet', style: AppTextStyles.h3),
          const SizedBox(height: 6),
          const Text(
            'Tap "Add Slot" to set your\navailable hours for this day.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}
