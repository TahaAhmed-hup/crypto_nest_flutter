import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(const SettingsState(
          notificationsEnabled: true,
          darkMode: true,
        ));

  void toggleNotifications(bool v) =>
      emit(state.copyWith(notificationsEnabled: v));

  void toggleDarkMode(bool v) => emit(state.copyWith(darkMode: v));
}
