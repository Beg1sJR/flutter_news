part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final Brightness brightness;
  final String language;
  final bool notificationsEnabled;

  const SettingsState(
    this.brightness,
    this.language,
    this.notificationsEnabled,
  );

  SettingsState copyWith({
    Brightness? brightness,
    String? language,
    bool? notificationsEnabled,
  }) {
    return SettingsState(
      brightness ?? this.brightness,
      language ?? this.language,
      notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  @override
  List<Object> get props => [brightness, language, notificationsEnabled];
}
