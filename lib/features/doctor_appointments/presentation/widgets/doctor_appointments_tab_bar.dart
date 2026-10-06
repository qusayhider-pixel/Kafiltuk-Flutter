import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class DoctorAppointmentsTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final List<int> counts;

  const DoctorAppointmentsTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.counts,
  });

  static const List<String> _tabs = ['Pending', 'Upcoming', 'History'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color:
                        isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                  child: Text('${_tabs[index]} (${counts[index]})'),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}