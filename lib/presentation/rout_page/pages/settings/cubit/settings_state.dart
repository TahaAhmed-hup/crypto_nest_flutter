class SettingsState {
  final bool notificationsEnabled;
  final bool darkMode;

  const SettingsState({
    required this.notificationsEnabled,
    required this.darkMode,
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? darkMode,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
