import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/portfolio_storage.dart';
import 'portfolio_state.dart';
class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit()
      : super(
          const PortfolioState(
            name: 'User',
            email: null,
            selfiePath: null,
            hasAssets: false,
          ),
        );

  Future<void> init() async {
    final email = await ProfileStorage.getEmail();
    final selfie = await ProfileStorage.getSelfiePath();

    final name = (email == null || email.trim().isEmpty)
        ? 'User'
        : _prettifyEmailName(email);

    emit(
      state.copyWith(
        email: email,
        selfiePath: selfie,
        name: name,
      ),
    );
  }

  void toggleDemoAssets() {
    emit(state.copyWith(hasAssets: !state.hasAssets));
  }

  String _prettifyEmailName(String email) {
    final raw = email.split('@').first;

    return raw
        .replaceAll('.', ' ')
        .replaceAll('_', ' ')
        .split(' ')
        .where((w) => w.trim().isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }
}
