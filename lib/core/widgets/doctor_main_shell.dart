import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';

class DoctorMainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DoctorMainShell({super.key, required this.navigationShell});

  static const List<_DoctorNavItem> _items = [
    _DoctorNavItem(icon: Icons.space_dashboard_rounded, label: 'Home'),
    _DoctorNavItem(icon: Icons.event_available_rounded, label: 'Schedule'),
    _DoctorNavItem(icon: Icons.fact_check_rounded, label: 'Appointments'),
    _DoctorNavItem(icon: Icons.person_outline_rounded, label: 'Profile'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08), // ظل ناعم جداً
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.85),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_items.length, (index) {
                  final isSelected = navigationShell.currentIndex == index;
                  final item = _items[index];

                  return GestureDetector(
                    onTap: () => navigationShell.goBranch(
                      index,
                      initialLocation: index == navigationShell.currentIndex,
                    ),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(
                                0.12,
                              )
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          20,
                        ), 
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.icon,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textMuted,
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeOutCubic,
                            child: SizedBox(
                              width: isSelected ? null : 0,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(width: 8),
                                  Text(
                                    item.label,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DoctorNavItem {
  final IconData icon;
  final String label;
  const _DoctorNavItem({required this.icon, required this.label});
}
