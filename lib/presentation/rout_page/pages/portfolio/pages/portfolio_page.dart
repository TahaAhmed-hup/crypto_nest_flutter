import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/portfolio_cubit.dart';
import '../cubit/portfolio_state.dart';
import '../widgets/portfolio_profile_header.dart';
import '../widgets/portfolio_balance_card.dart';
import '../widgets/empty_portfolio.dart';
import '../widgets/portfolio_asset_tile.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PortfolioCubit()..init(),
      child: const _PortfolioView(),
    );
  }
}

class _PortfolioView extends StatelessWidget {
  const _PortfolioView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Portfolio'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Toggle demo',
            icon: const Icon(Icons.swap_horiz),
            onPressed: () => context.read<PortfolioCubit>().toggleDemoAssets(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<PortfolioCubit, PortfolioState>(
            builder: (context, state) {
              return Column(
                children: [
                  PortfolioProfileHeader(
                    name: state.name,
                    email: state.email,
                    selfiePath: state.selfiePath,
                  ),
                  const SizedBox(height: 14),
                  const PortfolioBalanceCard(),
                  const SizedBox(height: 14),

                  Expanded(
                    child: state.hasAssets
                        ? ListView(
                            children: const [
                              PortfolioAssetTile(
                                icon: Icons.currency_bitcoin,
                                name: 'Bitcoin',
                                symbol: 'BTC',
                                value: '\$7,200.00',
                                amount: '0.15 BTC',
                              ),
                              SizedBox(height: 12),
                              PortfolioAssetTile(
                                icon: Icons.token,
                                name: 'Ethereum',
                                symbol: 'ETH',
                                value: '\$3,100.00',
                                amount: '0.52 ETH',
                              ),
                            ],
                          )
                        : const EmptyPortfolio(),
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
