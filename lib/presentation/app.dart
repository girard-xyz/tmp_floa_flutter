import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:movie_explorer/core/di/injection.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:movie_explorer/core/l10n/app_localizations.dart';

import 'package:movie_explorer/presentation/blocs/settings/settings_bloc.dart';
import 'package:movie_explorer/presentation/blocs/settings/settings_event.dart';
import 'package:movie_explorer/presentation/blocs/settings/settings_state.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:movie_explorer/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:movie_explorer/presentation/blocs/favorites/favorites_event.dart';

import 'package:movie_explorer/presentation/pages/home_page.dart';
import 'package:movie_explorer/presentation/pages/movie_details_page.dart';

class MovieExplorerApp extends StatelessWidget {
  const MovieExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SettingsBloc(
            getThemeUseCase: locator(),
            setThemeUseCase: locator(),
            getLanguageUseCase: locator(),
            setLanguageUseCase: locator(),
          )..add(LoadSettings()),
        ),
        BlocProvider(
          create: (_) => PopularMoviesBloc(getPopularMoviesUseCase: locator()),
        ),
        BlocProvider(
          create: (_) => FavoritesBloc(
            getFavorites: locator(),
            saveFavorite: locator(),
            removeFavorite: locator(),
          )..add(LoadFavorites()),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          return MaterialApp(
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.appTitle,
            locale: settingsState.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('fr', ''), // Français
              Locale('en', ''), // English
            ],
            themeMode: settingsState.themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.amber,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF151515),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF151515),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Color(0xFF151515),
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.amber,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            home: const HomePage(),
            onGenerateRoute: (settings) {
              if (settings.name != null &&
                  settings.name!.startsWith('/movie/')) {
                final id = settings.name!.replaceFirst('/movie/', '');
                return MaterialPageRoute(
                  settings: settings,
                  builder: (context) => MovieDetailsPage(movieId: id),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
