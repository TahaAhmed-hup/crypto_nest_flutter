import 'package:flutter_bloc/flutter_bloc.dart';

class RootCubit extends Cubit<int> {
  RootCubit() : super(0);

  void changeTab(int index) => emit(index);
}
