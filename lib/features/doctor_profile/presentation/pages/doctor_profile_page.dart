import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../profile/presentation/widgets/profile_tile.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Log out', style: AppTextStyles.h3),
          content: const Text(
            'Are you sure you want to log out of your doctor account?',
            style: AppTextStyles.body,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.go(AppRouter.login);
              },
              child: const Text(
                'Log out',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('My Profile', style: AppTextStyles.h1),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: AppColors.splashGradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.medical_services_rounded,
                            color: Colors.white,
                            size: 44,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.background,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text('Dr. Sarah Ahmed', style: AppTextStyles.h2),
                    const SizedBox(height: 4),
                    const Text(
                      'Cardiologist • City Medical Center',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: const [
                  _StatCardMini(label: 'Patients', value: '1.8K+'),
                  SizedBox(width: 12),
                  _StatCardMini(label: 'Experience', value: '12 yrs'),
                  SizedBox(width: 12),
                  _StatCardMini(label: 'Rating', value: '4.9'),
                ],
              ),
              const SizedBox(height: 28),
              const Text('Clinic', style: AppTextStyles.h3),
              const SizedBox(height: 14),
              ProfileTile(
                icon: Icons.local_hospital_outlined,
                iconColor: AppColors.primary,
                iconBackgroundColor: AppColors.primary.withOpacity(0.1),
                title: 'Clinic Details',
                onTap: () {},
              ),
              ProfileTile(
                icon: Icons.payments_outlined,
                iconColor: AppColors.textSecondary,
                iconBackgroundColor: AppColors.dentalCategory,
                title: 'Consultation Fees',
                onTap: () {},
              ),
              const SizedBox(height: 18),
              const Text('Account', style: AppTextStyles.h3),
              const SizedBox(height: 14),
              ProfileTile(
                icon: Icons.notifications_none_rounded,
                iconColor: AppColors.primary,
                iconBackgroundColor: AppColors.primary.withOpacity(0.1),
                title: 'Notifications',
                onTap: () {},
              ),
              ProfileTile(
                icon: Icons.settings_outlined,
                iconColor: AppColors.textSecondary,
                iconBackgroundColor: AppColors.dentalCategory,
                title: 'Settings',
                onTap: () {},
              ),
              const SizedBox(height: 8),
              ProfileTile(
                icon: Icons.logout_rounded,
                iconColor: Colors.redAccent,
                iconBackgroundColor: Colors.redAccent.withOpacity(0.1),
                title: 'Logout',
                isDestructive: true,
                onTap: () => _showLogoutDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCardMini extends StatelessWidget {
  final String label;
  final String value;

  const _StatCardMini({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(value, style: AppTextStyles.h2),
            const SizedBox(height: 4),
            Text(label, style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }
}