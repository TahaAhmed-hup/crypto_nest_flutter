import 'package:flutter/material.dart';

class CoinModel {
  final String name;
  final String symbol;
  final double price;
  final double changePercent;
  final IconData icon;

  /// Chart series (y-values). x is the index.
  final List<double> series;

  const CoinModel({
    required this.name,
    required this.symbol,
    required this.price,
    required this.changePercent,
    required this.icon,
    required this.series,
  });
}
