import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import 'package:movie_explorer/core/config/env.dart';

import 'package:movie_explorer/data/datasources/movie_local_data_source.dart';
import 'package:movie_explorer/data/datasources/movie_remote_data_source.dart';
import 'package:movie_explorer/data/datasources/settings_local_data_source.dart';
import 'package:movie_explorer/data/datasources/local/sqflite_local_data_source_impl.dart';
import 'package:movie_explorer/data/datasources/local/sqflite_settings_data_source_impl.dart';
import 'package:movie_explorer/data/datasources/tmdb/tmdb_remote_data_source_impl.dart';
import 'package:movie_explorer/data/datasources/tmdb/tmdb_api_client.dart';

import 'package:movie_explorer/domain/repositories/movie_repository.dart';
import 'package:movie_explorer/domain/repositories/settings_repository.dart';
import 'package:movie_explorer/data/repositories/movie_repository_impl.dart';
import 'package:movie_explorer/data/repositories/settings_repository_impl.dart';

import 'package:movie_explorer/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_explorer/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_explorer/domain/usecases/favorites_usecases.dart';
import 'package:movie_explorer/domain/usecases/settings_usecases.dart';

final locator = GetIt.instance;

void initDependencies(Database database) {
  // Externals
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(responseBody: kDebugMode));
  locator.registerLazySingleton<Dio>(() => dio);
  locator.registerLazySingleton<Database>(() => database);

  // Clients
  locator.registerLazySingleton<TmdbApiClient>(
    () => TmdbApiClient(locator<Dio>()),
  );

  // Data Sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => TmdbRemoteDataSourceImpl(locator<TmdbApiClient>()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => SqfliteLocalDataSourceImpl(database: locator<Database>()),
  );
  locator.registerLazySingleton<SettingsLocalDataSource>(
    () => SqfliteSettingsDataSourceImpl(locator<Database>()),
  );

  // Repositories
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator<MovieRemoteDataSource>(),
      localDataSource: locator<MovieLocalDataSource>(),
      apiKey: Env.tmdbApiKey,
    ),
  );
  locator.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      localDataSource: locator<SettingsLocalDataSource>(),
    ),
  );

  // Use Cases
  // Movies
  locator.registerLazySingleton(
    () => GetPopularMoviesUseCase(locator<MovieRepository>()),
  );
  locator.registerLazySingleton(
    () => GetMovieDetailsUseCase(locator<MovieRepository>()),
  );
  locator.registerLazySingleton(
    () => GetFavoritesUseCase(locator<MovieRepository>()),
  );
  locator.registerLazySingleton(
    () => SaveFavoriteUseCase(locator<MovieRepository>()),
  );
  locator.registerLazySingleton(
    () => RemoveFavoriteUseCase(locator<MovieRepository>()),
  );

  // Settings
  locator.registerLazySingleton(
    () => GetThemeUseCase(locator<SettingsRepository>()),
  );
  locator.registerLazySingleton(
    () => SetThemeUseCase(locator<SettingsRepository>()),
  );
  locator.registerLazySingleton(
    () => GetLanguageUseCase(locator<SettingsRepository>()),
  );
  locator.registerLazySingleton(
    () => SetLanguageUseCase(locator<SettingsRepository>()),
  );
}
