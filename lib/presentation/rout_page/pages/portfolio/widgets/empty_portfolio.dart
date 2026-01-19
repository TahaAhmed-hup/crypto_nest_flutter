import 'package:flutter/material.dart';

class EmptyPortfolio extends StatelessWidget {
  const EmptyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF26282F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF343640)),
      ),
      child: const Column(
        children: [
          Icon(Icons.wallet_outlined, color: Colors.white54, size: 40),
          SizedBox(height: 10),
          Text(
            'No assets yet',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 6),
          Text(
            'Add coins to build your portfolio.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
