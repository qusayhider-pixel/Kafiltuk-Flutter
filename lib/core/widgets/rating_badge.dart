import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final int? reviewsCount;

  const RatingBadge({super.key, required this.rating, this.reviewsCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, size: 16, color: AppColors.star),
        const SizedBox(width: 4),
        Text(rating.toString(), style: AppTextStyles.bodyBold),
        if (reviewsCount != null) ...[
          const SizedBox(width: 4),
          Text('($reviewsCount reviews)', style: AppTextStyles.caption),
        ],
      ],
    );
  }
}