import '../../home/data/coin_model.dart';

class MarketState {
  final String query;
  final List<CoinModel> allCoins;
  final List<CoinModel> filteredCoins;

  const MarketState({
    required this.query,
    required this.allCoins,
    required this.filteredCoins,
  });

  MarketState copyWith({
    String? query,
    List<CoinModel>? allCoins,
    List<CoinModel>? filteredCoins,
  }) {
    return MarketState(
      query: query ?? this.query,
      allCoins: allCoins ?? this.allCoins,
      filteredCoins: filteredCoins ?? this.filteredCoins,
    );
  }
}
