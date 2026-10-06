import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/appointments_action_cubit.dart';
import '../widgets/doctor_appointment_card.dart';
import '../widgets/doctor_appointments_tab_bar.dart';
import '../widgets/pending_appointment_card.dart';

class DoctorAppointmentsPage extends StatelessWidget {
  const DoctorAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppointmentsActionCubit(),
      child: const _DoctorAppointmentsView(),
    );
  }
}

class _DoctorAppointmentsView extends StatelessWidget {
  const _DoctorAppointmentsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Appointments', style: AppTextStyles.h1),
              const SizedBox(height: 4),
              const Text(
                'Manage your patient requests and visits',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 20),
              BlocBuilder<AppointmentsActionCubit, AppointmentsActionState>(
                builder: (context, state) {
                  return DoctorAppointmentsTabBar(
                    selectedIndex: state.selectedTabIndex,
                    counts: [
                      state.pending.length,
                      state.upcoming.length,
                      state.history.length,
                    ],
                    onTabSelected: (index) => context
                        .read<AppointmentsActionCubit>()
                        .selectTab(index),
                  );
                },
              ),
              const SizedBox(height: 18),
              Expanded(
                child: BlocBuilder<AppointmentsActionCubit,
                    AppointmentsActionState>(
                  builder: (context, state) {
                    if (state.loadStatus == AppointmentsLoadStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }

                    if (state.selectedTabIndex == 0) {
                      if (state.pending.isEmpty) {
                        return _buildEmptyState(
                          icon: Icons.inbox_rounded,
                          message: 'No pending requests right now.',
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: state.pending.length,
                        itemBuilder: (context, index) {
                          final appointment = state.pending[index];
                          return PendingAppointmentCard(
                            appointment: appointment,
                            isProcessing:
                                state.processingId == appointment.id,
                            onAccept: () => context
                                .read<AppointmentsActionCubit>()
                                .acceptAppointment(appointment.id),
                            onReject: () => context
                                .read<AppointmentsActionCubit>()
                                .rejectAppointment(appointment.id),
                          );
                        },
                      );
                    }

                    final list = state.selectedTabIndex == 1
                        ? state.upcoming
                        : state.history;

                    if (list.isEmpty) {
                      return _buildEmptyState(
                        icon: Icons.event_note_rounded,
                        message: state.selectedTabIndex == 1
                            ? 'No upcoming appointments yet.'
                            : 'No past appointments yet.',
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return DoctorAppointmentCard(appointment: list[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState({required IconData icon, required String message}) {
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
            child: Icon(icon, size: 36, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}