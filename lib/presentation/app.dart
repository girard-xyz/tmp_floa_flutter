import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_explorer/core/l10n/app_localizations.dart';

import 'package:movie_explorer/core/config/env.dart';
import 'package:movie_explorer/data/datasources/tmdb/tmdb_api_client.dart';
import 'package:movie_explorer/data/datasources/tmdb/tmdb_remote_data_source_impl.dart';
import 'package:movie_explorer/data/datasources/local/sqflite_local_data_source_impl.dart';
import 'package:movie_explorer/data/repositories/movie_repository_impl.dart';
import 'package:movie_explorer/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_explorer/domain/usecases/favorites_usecases.dart';

import 'package:movie_explorer/data/datasources/local/sqflite_settings_data_source_impl.dart';
import 'package:movie_explorer/data/repositories/settings_repository_impl.dart';
import 'package:movie_explorer/domain/usecases/settings_usecases.dart';

import 'package:movie_explorer/presentation/blocs/settings/settings_bloc.dart';
import 'package:movie_explorer/presentation/blocs/settings/settings_event.dart';
import 'package:movie_explorer/presentation/blocs/settings/settings_state.dart';

import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:movie_explorer/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:movie_explorer/presentation/blocs/favorites/favorites_event.dart';
import 'package:movie_explorer/presentation/pages/home_page.dart';

class MovieExplorerApp extends StatelessWidget {
  final Database database;

  const MovieExplorerApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: false));

    final tmdbApiClient = TmdbApiClient(dio);
    final remoteDataSource = TmdbRemoteDataSourceImpl(tmdbApiClient);

    // Instanciation de la source locale des films
    final localDataSource = SqfliteLocalDataSourceImpl(database: database);

    final repository = MovieRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      apiKey: Env.tmdbApiKey,
    );

    // Instanciation des sources de réglages
    final settingsDataSource = SqfliteSettingsDataSourceImpl(database);
    final settingsRepo = SettingsRepositoryImpl(
      localDataSource: settingsDataSource,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SettingsBloc(
            getThemeUseCase: GetThemeUseCase(settingsRepo),
            setThemeUseCase: SetThemeUseCase(settingsRepo),
            getLanguageUseCase: GetLanguageUseCase(settingsRepo),
            setLanguageUseCase: SetLanguageUseCase(settingsRepo),
          )..add(LoadSettings()),
        ),
        BlocProvider(
          create: (_) => PopularMoviesBloc(
            getPopularMoviesUseCase: GetPopularMoviesUseCase(repository),
          ),
        ),
        BlocProvider(
          create: (_) => FavoritesBloc(
            getFavorites: GetFavoritesUseCase(repository),
            saveFavorite: SaveFavoriteUseCase(repository),
            removeFavorite: RemoveFavoriteUseCase(repository),
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
          );
        },
      ),
    );
  }
}
