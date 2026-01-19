import 'package:flutter/material.dart';

import '../../../core/configs/theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const barColor = Color(0xFF1E2026);

    return SafeArea(
      top: false,
      child: Container(
        // كان 78.. خلّيه أكبر شوية
        height: 86,
        decoration: const BoxDecoration(
          color: barColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          notchMargin: 10,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(
                label: 'Home',
                icon: Icons.home_outlined,
                isActive: currentIndex == 0,
                onTap: () => onChanged(0),
              ),
              _NavItem(
                label: 'Market',
                icon: Icons.bar_chart_outlined,
                isActive: currentIndex == 1,
                onTap: () => onChanged(1),
              ),

              const SizedBox(width: 56),

              _NavItem(
                label: 'Portfolio',
                icon: Icons.pie_chart_outline,
                isActive: currentIndex == 2,
                onTap: () => onChanged(2),
              ),
              _NavItem(
                label: 'Setting',
                icon: Icons.settings_outlined,
                isActive: currentIndex == 3,
                onTap: () => onChanged(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : Colors.white54;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: 72,
        height: 56, // كان 60.. قلّله
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22), // قلّل 24 → 22
            const SizedBox(height: 2),          // قلّل المسافة
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 11, // قلّل 12 → 11
                fontWeight: FontWeight.w600,
                height: 1.0,  // يمنع زيادة ارتفاع الخط
              ),
            ),
          ],
        ),
      ),
    );
  }
}
