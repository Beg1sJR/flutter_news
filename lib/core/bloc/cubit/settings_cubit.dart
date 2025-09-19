import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news/features/profile/domain/repository/settings/settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepository)
    : super(const SettingsState(Brightness.light, 'ru')) {
    checkTheme();
    loadLanguage();
  }

  final SettingsRepository _settingsRepository;

  Future<void> setTheme(Brightness brightness) async {
    emit(SettingsState(brightness, state.language));
    await _settingsRepository.setDarkMode(brightness == Brightness.dark);
  }

  void checkTheme() {
    final brightness = _settingsRepository.getDarkMode()
        ? Brightness.dark
        : Brightness.light;
    emit(state.copyWith(brightness: brightness));
  }

  Future<void> setLanguage(String languageCode) async {
    emit(state.copyWith(language: languageCode));
    await _settingsRepository.setLanguage(languageCode);
  }

  void loadLanguage() {
    final language = _settingsRepository.getLanguage();
    emit(state.copyWith(language: language));
  }
}
