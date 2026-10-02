import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiltuk/features/doctor_booking/presentation/cubit/doctor_booking_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/rating_badge.dart';
import '../../data/models/doctor_model.dart';
import '../cubit/doctor_booking_cubit.dart';
import '../widgets/booking_success_sheet.dart';
import '../widgets/date_chip.dart';
import '../widgets/stat_item.dart';
import '../widgets/time_slot_chip.dart';

class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorBookingCubit(),
      child: _DoctorDetailsView(doctor: doctor),
    );
  }
}

class _DoctorDetailsView extends StatelessWidget {
  final Doctor doctor;

  const _DoctorDetailsView({required this.doctor});

  void _showBookingSheet(BuildContext context, DoctorBookingState state) {
    context.read<DoctorBookingCubit>().confirmBooking();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => BookingSuccessSheet(
        doctor: doctor,
        date: state.selectedDate,
        time: state.selectedTime!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RoundIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Text('Doctor Details', style: AppTextStyles.h3),
                  const _RoundIconButton(icon: Icons.favorite_border_rounded),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.pinkCard,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: AppColors.success,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        doctor.availableToday
                                            ? 'Available today'
                                            : 'Available tomorrow',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(doctor.name, style: AppTextStyles.h1),
                                const SizedBox(height: 4),
                                Text(
                                  doctor.specialty,
                                  style: AppTextStyles.bodyBold,
                                ),
                                Text(
                                  doctor.hospitalName,
                                  style: AppTextStyles.caption,
                                ),
                                const SizedBox(height: 10),
                                RatingBadge(rating: doctor.rating),
                              ],
                            ),
                          ),
                          Stack(
                            children: [
                              Hero(
                                tag: 'doctor_image_${doctor.id}',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.network(
                                    doctor.imageUrl,
                                    width: 110,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.verified_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        StatItem(
                          icon: Icons.groups_rounded,
                          iconColor: AppColors.primary,
                          backgroundColor:
                              AppColors.primary.withOpacity(0.1),
                          value: doctor.formattedPatients,
                          label: 'Patients',
                        ),
                        StatItem(
                          icon: Icons.workspace_premium_rounded,
                          iconColor: Colors.teal,
                          backgroundColor: AppColors.dentalCategory,
                          value: '${doctor.experienceYears} years',
                          label: 'Experience',
                        ),
                        StatItem(
                          icon: Icons.chat_bubble_rounded,
                          iconColor: Colors.orange,
                          backgroundColor: AppColors.eyeCategory,
                          value: '${doctor.reviewsCount}',
                          label: 'Reviews',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text('About doctor', style: AppTextStyles.h3),
                    const SizedBox(height: 8),
                    Text(doctor.about, style: AppTextStyles.body),
                    const SizedBox(height: 24),
                    const Text('Select appointment date', style: AppTextStyles.h3),
                    const SizedBox(height: 12),
                    BlocBuilder<DoctorBookingCubit, DoctorBookingState>(
                      builder: (context, state) {
                        return SizedBox(
                          height: 78,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.availableDates.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final date = state.availableDates[index];
                              final isToday = date.day == today.day &&
                                  date.month == today.month &&
                                  date.year == today.year;
                              return DateChip(
                                date: date,
                                isToday: isToday,
                                isSelected: state.selectedDateIndex == index,
                                onTap: () => context
                                    .read<DoctorBookingCubit>()
                                    .selectDate(index),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text('Available time', style: AppTextStyles.h3),
                    const SizedBox(height: 12),
                    BlocBuilder<DoctorBookingCubit, DoctorBookingState>(
                      builder: (context, state) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.availableTimes.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2.4,
                          ),
                          itemBuilder: (context, index) {
                            return TimeSlotChip(
                              time: state.availableTimes[index],
                              isSelected: state.selectedTimeIndex == index,
                              onTap: () => context
                                  .read<DoctorBookingCubit>()
                                  .selectTime(index),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: BlocBuilder<DoctorBookingCubit, DoctorBookingState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Consultation fee',
                                style: AppTextStyles.caption,
                              ),
                              Text(
                                'Rs. ${doctor.consultationFee}',
                                style: AppTextStyles.h2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 190,
                          child: PrimaryButton(
                            label: 'Book appointment',
                            onPressed: state.canBook
                                ? () => _showBookingSheet(context, state)
                                : null,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _RoundIconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
          ],
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}