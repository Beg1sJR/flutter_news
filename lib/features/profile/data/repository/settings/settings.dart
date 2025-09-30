import 'package:news/features/profile/domain/repository/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences _sharedPreferences;

  SettingsRepositoryImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  static const String _darkModeKey = 'dark_mode';
  static const String _languages = 'languages';
  static const String _notificationsKey = 'notifications_enabled';

  @override
  bool getDarkMode() {
    final selected = _sharedPreferences.getBool(_darkModeKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    await _sharedPreferences.setBool(_darkModeKey, isDarkMode);
  }

  @override
  String getLanguage() {
    final selected = _sharedPreferences.getString(_languages);
    return selected ?? 'ru';
  }

  @override
  Future<void> setLanguage(String language) async {
    await _sharedPreferences.setString(_languages, language);
  }

  @override
  bool getNotificationsEnabled() {
    final enabled = _sharedPreferences.getBool(_notificationsKey);
    return enabled ?? true;
  }

  @override
  Future<void> setNotificationsEnabled(bool isEnabled) async {
    await _sharedPreferences.setBool(_notificationsKey, isEnabled);
  }
}
