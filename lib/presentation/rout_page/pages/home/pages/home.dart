import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

import '../widget/balance_header.dart';
import '../widget/coin_card.dart';
import '../widget/coins_bottom_sheet.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_label_text.dart';
import '../widget/news_card.dart';
import '../widget/news_list_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..init(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BalanceHeader(),
                  const SizedBox(height: 32),

                  // Top Coins
                  CustomLabelText(
                    title: 'Top Coins',
                    actionText: 'See All',
                    onActionTap: () => showCoinsBottomSheet(context, state.coins),
                  ),
                  const SizedBox(height: 22),

                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.coins.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 40),
                      itemBuilder: (context, index) {
                        return CoinCard(coin: state.coins[index]);
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // News
                  CustomLabelText(
                    title: 'News',
                    actionText: 'See All',
                    onActionTap: () => showNewsListBottomSheet(context, state.news),
                  ),
                  const SizedBox(height: 22),

                  ...List.generate(
                    state.news.length > 2 ? 2 : state.news.length,
                    (i) => Padding(
                      padding: EdgeInsets.only(bottom: i == 1 ? 0 : 22),
                      child: NewsCard(news: state.news[i]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
