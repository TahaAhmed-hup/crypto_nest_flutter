import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/home_fake_data.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(coins: [], news: []));

  void init() {
    emit(
      state.copyWith(
        coins: HomeFakeData.coins,
        news: HomeFakeData.news,
      ),
    );
  }
}
