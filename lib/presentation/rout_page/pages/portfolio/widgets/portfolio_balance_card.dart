import 'package:flutter/material.dart';

class PortfolioBalanceCard extends StatelessWidget {
  final String total;
  final String profit;

  const PortfolioBalanceCard({
    super.key,
    this.total = '\$12,540.22',
    this.profit = '+\$540.22 (4.5%)',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF26282F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF343640)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            total,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            profit,
            style: const TextStyle(
              color: Color(0xFF22E07A),
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
