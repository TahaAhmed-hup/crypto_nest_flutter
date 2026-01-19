import 'package:flutter/material.dart';

import '../../../../../core/configs/theme/app_colors.dart';

class CustomLabelText extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onActionTap;
  const CustomLabelText({
    super.key,
    required this.title,
    required this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: const TextStyle(fontSize: 14, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
