import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../data/coin_model.dart';

class CoinCard extends StatelessWidget {
  final CoinModel coin;

  /// Solid colors (زي الصورة)
  final Color cardColor;   // خلفية الكرت
  final Color borderColor; // بوردر خفيف

  final double width;
  final double height;

  const CoinCard({
    super.key,
    required this.coin,
    this.cardColor = const Color(0xFF26282F),
    this.borderColor = const Color(0xFF343640),
    this.width = 165,
    this.height = 175,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = coin.changePercent >= 0;
    const green = Color(0xFF22E07A);
    const red = Color(0xFFE24A4A);

    final changeColor = isPositive ? green : red;
    final changeText =
        '${isPositive ? '+' : ''}${coin.changePercent.toStringAsFixed(2)}%';

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              _CoinBadge(icon: coin.icon),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  coin.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Price
          Text(
            _formatPrice(coin.price),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 4),

          // Change
          Text(
            changeText,
            style: TextStyle(
              color: changeColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          // Chart
          Expanded(
            child: _CoinLineChart(
              series: coin.series,
              lineColor: green,
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double value) {
    // $45,898.16
    final s = value.toStringAsFixed(2);
    final parts = s.split('.');
    final intPart = parts[0];
    final dec = parts[1];

    final buf = StringBuffer();
    for (int i = 0; i < intPart.length; i++) {
      final idxFromEnd = intPart.length - i;
      buf.write(intPart[i]);
      if (idxFromEnd > 1 && idxFromEnd % 3 == 1) buf.write(',');
    }
    return '\$${buf.toString()}.$dec';
  }
}

class _CoinBadge extends StatelessWidget {
  final IconData icon;
  const _CoinBadge({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: const BoxDecoration(
        color: Color(0xFF1E2026),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: Colors.white),
    );
  }
}

class _CoinLineChart extends StatelessWidget {
  final List<double> series;
  final Color lineColor;

  const _CoinLineChart({
    required this.series,
    required this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    if (series.isEmpty) return const SizedBox.shrink();

    final spots = <FlSpot>[];
    for (int i = 0; i < series.length; i++) {
      spots.add(FlSpot(i.toDouble(), series[i]));
    }

    final minY = series.reduce((a, b) => a < b ? a : b);
    final maxY = series.reduce((a, b) => a > b ? a : b);
    final diff = (maxY - minY);
    final pad = diff == 0 ? 1.0 : diff * 0.2;

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (series.length - 1).toDouble(),
        minY: minY - pad,
        maxY: maxY + pad,
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData:  FlBorderData(show: false),
        lineTouchData: const LineTouchData(enabled: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.35,
            color: lineColor,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            // زي الصورة تقريبًا: بدون Fill واضح
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
