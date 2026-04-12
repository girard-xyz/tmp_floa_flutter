abstract class SettingsRepository {
  Future<String> getTheme();
  Future<void> setTheme(String theme);
  Future<String> getLanguage();
  Future<void> setLanguage(String language);
}
