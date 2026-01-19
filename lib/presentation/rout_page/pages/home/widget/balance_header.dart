import 'package:flutter/material.dart';
import 'balance_card.dart';

class _CardData {
  final String title;
  final String balance;
  final String profit;
  final LinearGradient gradient;

  const _CardData({
    required this.title,
    required this.balance,
    required this.profit,
    required this.gradient,
  });
}

class BalanceHeader extends StatefulWidget {
  const BalanceHeader({super.key});

  @override
  State<BalanceHeader> createState() => _BalanceHeaderState();
}

class _BalanceHeaderState extends State<BalanceHeader> {
  // أول عنصر = الكارت اللي قدّام (الأعرض)
  final List<_CardData> _cards = [
    const _CardData(
      title: 'Total Balance',
      balance: '\$18,368.11',
      profit: '\$1,816  Today\'s Profit',
      gradient: LinearGradient(
        colors: [Color(0xFFB8D0F5), Color(0xFF5C90F4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    const _CardData(
      title: 'Savings',
      balance: '\$12,450.00',
      profit: '\$640  Today\'s Profit',
      gradient: LinearGradient(
        colors: [Color(0xFFFFE08A), Color(0xFFFFC94A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    const _CardData(
      title: 'Trading',
      balance: '\$6,200.00',
      profit: '\$210  Today\'s Profit',
      gradient: LinearGradient(
        colors: [Color(0xFFFFF1B0), Color(0xFFFFD666)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ];

  void _bringToFront(int index) {
    if (index == 0) return;
    setState(() {
      final picked = _cards.removeAt(index);
      _cards.insert(0, picked); // يبقى قدّام (الأعرض)
    });
  }

  @override
  Widget build(BuildContext context) {
    // قدّام أعرض، ورا أضيق
    const placements = [
      _Placement(top: 0, side: 32),    // front (widest)
      _Placement(top: 16, side: 20),  // middle
      _Placement(top: 24, side: 0),  // back (narrowest)
    ];

    return SizedBox(
      height: 185,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(_cards.length, (i) {
          final c = _cards[i];
          final p = placements[i];

          return AnimatedPositioned(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            top: p.top,
            left: p.side,
            right: p.side,
            child: BalanceCard(
              title: c.title,
              balance: c.balance,
              profit: c.profit,
              gradient: c.gradient,
              onTap: () => _bringToFront(i),
            ),
          );
        }),
      ),
    );
  }
}

class _Placement {
  final double top;
  final double side;

  const _Placement({
    required this.top,
    required this.side,
  });
}
