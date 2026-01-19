import '../../home/data/coin_model.dart';
import 'package:flutter/material.dart';

class MarketFakeData {
  static const allCoins = <CoinModel>[
    CoinModel(
      name: 'Bitcoin',
      symbol: 'BTC',
      price: 45898.16,
      changePercent: 24.55,
      icon: Icons.currency_bitcoin,
      series: [2.2, 2.8, 2.4, 3.2, 2.9, 3.7, 3.4, 4.2, 3.8],
    ),
    CoinModel(
      name: 'Ethereum',
      symbol: 'ETH',
      price: 5898.16,
      changePercent: 2.55,
      icon: Icons.token,
      series: [1.6, 2.0, 1.9, 2.4, 2.2, 2.9, 2.6, 3.1, 2.8],
    ),
    CoinModel(
      name: 'Solana',
      symbol: 'SOL',
      price: 189.40,
      changePercent: -1.22,
      icon: Icons.bolt,
      series: [3.0, 3.1, 2.9, 3.2, 3.05, 3.0, 2.95],
    ),
    CoinModel(
      name: 'BNB',
      symbol: 'BNB',
      price: 610.10,
      changePercent: 0.78,
      icon: Icons.circle,
      series: [2.1, 2.15, 2.12, 2.18, 2.2, 2.17],
    ),
  ];
}
