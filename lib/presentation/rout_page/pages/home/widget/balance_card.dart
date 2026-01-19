import 'package:flutter/material.dart';
import 'package:crypto_nest/core/configs/assets/app_images.dart';

class BalanceCard extends StatelessWidget {
  final String title;
  final String balance;
  final String profit;
  final LinearGradient gradient;
  final VoidCallback? onTap;

  const BalanceCard({
    super.key,
    required this.title,
    required this.balance,
    required this.profit,
    required this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Text content
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        balance,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.05,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.trending_up,
                            size: 14,
                            color: Color(0xFF22C55E),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            profit,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Small coin (top-right inside)
                Positioned(
                  top: 14,
                  right: 56,
                  child: Image.asset(
                    AppImages.Bitcoin,
                    width: 18,
                    height: 18,
                    fit: BoxFit.contain,
                  ),
                ),

                // Big coin (bottom-right, overflow outside)
                Positioned(
                  right: -18,
                  bottom: -18,
                  child: Image.asset(
                    AppImages.Bitcoin,
                    width: 90,
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
