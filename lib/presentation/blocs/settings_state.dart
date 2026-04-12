import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;
  final String rawTheme;
  final String rawLanguage;

  const SettingsState({
    required this.themeMode,
    required this.locale,
    required this.rawTheme,
    required this.rawLanguage,
  });

  factory SettingsState.initial() => const SettingsState(
    themeMode: ThemeMode.system,
    locale: Locale('fr'),
    rawTheme: 'system',
    rawLanguage: 'fr',
  );

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    String? rawTheme,
    String? rawLanguage,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      rawTheme: rawTheme ?? this.rawTheme,
      rawLanguage: rawLanguage ?? this.rawLanguage,
    );
  }

  @override
  List<Object> get props => [themeMode, locale, rawTheme, rawLanguage];
}
