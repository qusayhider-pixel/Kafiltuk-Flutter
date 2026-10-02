import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : backgroundColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : iconColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
              color: isSelected
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}