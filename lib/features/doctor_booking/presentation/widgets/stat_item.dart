import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String value;
  final String label;

  const StatItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(height: 6),
        Text(value, style: AppTextStyles.bodyBold),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}