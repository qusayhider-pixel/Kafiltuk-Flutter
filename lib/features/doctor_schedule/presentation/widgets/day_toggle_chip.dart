import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class DayToggleChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isActive;
  final VoidCallback onTap;

  const DayToggleChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 54,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Column(
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
              child: Text(label),
            ),
            const SizedBox(height: 6),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? (isSelected ? Colors.white : AppColors.success)
                    : AppColors.textMuted.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}