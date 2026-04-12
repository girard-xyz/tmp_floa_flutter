abstract class SettingsLocalDataSource {
  Future<String?> getPreference(String key);
  Future<void> savePreference(String key, String value);
}
