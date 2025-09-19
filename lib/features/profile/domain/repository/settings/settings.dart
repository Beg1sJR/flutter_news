abstract interface class SettingsRepository {
  Future<void> setLanguage(String language);
  String getLanguage();

  Future<void> setDarkMode(bool isDarkMode);
  bool getDarkMode();

  Future<void> setNotificationsEnabled(bool isEnabled);
  bool getNotificationsEnabled();
}
