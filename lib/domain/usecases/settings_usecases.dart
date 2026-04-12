import 'package:movie_explorer/domain/repositories/settings_repository.dart';

class GetThemeUseCase {
  final SettingsRepository repository;
  GetThemeUseCase(this.repository);
  Future<String> call() => repository.getTheme();
}

class SetThemeUseCase {
  final SettingsRepository repository;
  SetThemeUseCase(this.repository);
  Future<void> call(String theme) => repository.setTheme(theme);
}

class GetLanguageUseCase {
  final SettingsRepository repository;
  GetLanguageUseCase(this.repository);
  Future<String> call() => repository.getLanguage();
}

class SetLanguageUseCase {
  final SettingsRepository repository;
  SetLanguageUseCase(this.repository);
  Future<void> call(String language) => repository.setLanguage(language);
}
