import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_nest/core/configs/theme/app_colors.dart';

import '../cubit/root_cubit.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'home/pages/home.dart';
import 'market/pages/market_page.dart';
import 'portfolio/pages/portfolio_page.dart';
import 'settings/pages/settings_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RootCubit(),
      child: const _RootView(),
    );
  }
}

class _RootView extends StatelessWidget {
  const _RootView();

  @override
  Widget build(BuildContext context) {
    const pages = <Widget>[
      HomePage(),
      MarketPage(),
      PortfolioPage(),
      SettingsPage(),
    ];

    return BlocBuilder<RootCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: const Color(0xFF101115),

          /// أفضل من pages[currentIndex] عشان يحافظ على state بتاع كل تاب
          body: IndexedStack(
            index: currentIndex,
            children: pages,
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _CenterFab(
            onTap: () {
              // أي Action
            },
          ),

          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: currentIndex,
            onChanged: (i) => context.read<RootCubit>().changeTab(i),
          ),
        );
      },
    );
  }
}

class _CenterFab extends StatelessWidget {
  final VoidCallback onTap;
  const _CenterFab({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 62,
        height: 62,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(.35),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
