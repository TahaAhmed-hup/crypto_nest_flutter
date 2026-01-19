import 'package:flutter/material.dart';
import '../../../../../core/configs/assets/app_images.dart';
import 'coin_model.dart';
import 'news_model.dart';

class HomeFakeData {
  static const coins = <CoinModel>[
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
  ];

  static const news = <NewsModel>[
    NewsModel(
      title: 'Analysts project 32% upside for Coinbase stock',
      imagePath: AppImages.MaskGroup,
      description:
          'Analysts expect Coinbase shares to rise by 32% driven by strong crypto adoption and institutional demand...',
    ),
    NewsModel(
      title: 'Bitcoin hits new resistance level as market turns bullish',
      imagePath: AppImages.MaskGroup,
      description:
          'Bitcoin price action shows strength, with traders watching key resistance zones closely...',
    ),
  ];
}
