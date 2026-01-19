
import '../data/coin_model.dart';
import '../data/news_model.dart';

class HomeState {
  final List<CoinModel> coins;
  final List<NewsModel> news;

  const HomeState({
    required this.coins,
    required this.news,
  });

  HomeState copyWith({
    List<CoinModel>? coins,
    List<NewsModel>? news,
  }) {
    return HomeState(
      coins: coins ?? this.coins,
      news: news ?? this.news,
    );
  }
}
