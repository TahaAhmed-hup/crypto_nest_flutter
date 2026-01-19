import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/market_cubit.dart';
import '../cubit/market_state.dart';
import '../widgets/market_search_bar.dart';
import '../widgets/market_coin_tile.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MarketCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF101115),
          elevation: 0,
          title: const Text('Market', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFF101115),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<MarketCubit, MarketState>(
            builder: (context, state) {
              return Column(
                children: [
                  MarketSearchBar(
                    onChanged: (q) => context.read<MarketCubit>().search(q),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.filteredCoins.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return MarketCoinTile(coin: state.filteredCoins[index]);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
