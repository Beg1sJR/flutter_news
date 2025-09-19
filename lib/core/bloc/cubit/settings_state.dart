part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final Brightness brightness;
  final String language;

  const SettingsState(this.brightness, this.language);

  SettingsState copyWith({Brightness? brightness, String? language}) {
    return SettingsState(
      brightness ?? this.brightness,
      language ?? this.language,
    );
  }

  @override
  List<Object> get props => [brightness, language];
}
