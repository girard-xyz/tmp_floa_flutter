import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/domain/usecases/settings_usecases.dart';
import 'package:movie_explorer/presentation/blocs/settings/settings_event.dart';
import 'package:movie_explorer/presentation/blocs/settings/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetThemeUseCase getThemeUseCase;
  final SetThemeUseCase setThemeUseCase;
  final GetLanguageUseCase getLanguageUseCase;
  final SetLanguageUseCase setLanguageUseCase;

  SettingsBloc({
    required this.getThemeUseCase,
    required this.setThemeUseCase,
    required this.getLanguageUseCase,
    required this.setLanguageUseCase,
  }) : super(SettingsState.initial()) {
    on<LoadSettings>((event, emit) async {
      final themeStr = await getThemeUseCase();
      final langStr = await getLanguageUseCase();
      emit(
        state.copyWith(
          themeMode: _parseTheme(themeStr),
          locale: Locale(langStr),
          rawTheme: themeStr,
          rawLanguage: langStr,
        ),
      );
    });

    on<ChangeTheme>((event, emit) async {
      await setThemeUseCase(event.theme);
      emit(
        state.copyWith(
          themeMode: _parseTheme(event.theme),
          rawTheme: event.theme,
        ),
      );
    });

    on<ChangeLanguage>((event, emit) async {
      await setLanguageUseCase(event.language);
      emit(
        state.copyWith(
          locale: Locale(event.language),
          rawLanguage: event.language,
        ),
      );
    });
  }

  ThemeMode _parseTheme(String theme) {
    switch (theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
