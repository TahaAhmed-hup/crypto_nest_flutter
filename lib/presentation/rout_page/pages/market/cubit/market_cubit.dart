import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/market_fake_data.dart';
import 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  MarketCubit()
      : super(
          const MarketState(
            query: '',
            allCoins: MarketFakeData.allCoins,
            filteredCoins: MarketFakeData.allCoins,
          ),
        );

  void search(String q) {
    final query = q.trim().toLowerCase();
    final filtered = state.allCoins.where((c) {
      return c.name.toLowerCase().contains(query) ||
          c.symbol.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(query: q, filteredCoins: filtered));
  }
}
