import 'package:movie_explorer/domain/repositories/settings_repository.dart';
import 'package:movie_explorer/data/datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<String> getTheme() async {
    return (await localDataSource.getPreference('theme')) ?? 'system';
  }

  @override
  Future<void> setTheme(String theme) async {
    await localDataSource.savePreference('theme', theme);
  }

  @override
  Future<String> getLanguage() async {
    return (await localDataSource.getPreference('language')) ?? 'fr';
  }

  @override
  Future<void> setLanguage(String language) async {
    await localDataSource.savePreference('language', language);
  }
}
