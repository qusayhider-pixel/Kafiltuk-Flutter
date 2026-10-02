import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/appointments_cubit.dart';
import '../widgets/appointment_card.dart';
import '../widgets/appointments_tab_bar.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppointmentsCubit(),
      child: const _AppointmentsView(),
    );
  }
}

class _AppointmentsView extends StatelessWidget {
  const _AppointmentsView();

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
              const Text('My Appointments', style: AppTextStyles.h1),
              const SizedBox(height: 4),
              const Text(
                'Track your upcoming and past visits',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 20),
              BlocBuilder<AppointmentsCubit, AppointmentsState>(
                builder: (context, state) {
                  return AppointmentsTabBar(
                    selectedIndex: state.selectedTabIndex,
                    onTabSelected: (index) =>
                        context.read<AppointmentsCubit>().selectTab(index),
                  );
                },
              ),
              const SizedBox(height: 18),
              Expanded(
                child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
                  builder: (context, state) {
                    if (state.loadStatus == AppointmentsLoadStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }

                    final appointments = state.filteredAppointments;

                    if (appointments.isEmpty) {
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
                                Icons.calendar_month_rounded,
                                size: 36,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No appointments here',
                              style: AppTextStyles.h3,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Appointments in this category\nwill show up here.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.body,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        return AppointmentCard(
                          appointment: appointments[index],
                        );
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
}