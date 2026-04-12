import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

import 'package:movie_explorer/core/config/env.dart';
import 'package:movie_explorer/data/datasources/tmdb/tmdb_api_client.dart';
import 'package:movie_explorer/data/datasources/tmdb/tmdb_remote_data_source_impl.dart';
import 'package:movie_explorer/data/datasources/local/sqflite_local_data_source_impl.dart';
import 'package:movie_explorer/data/repositories/movie_repository_impl.dart';
import 'package:movie_explorer/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_explorer/domain/usecases/favorites_usecases.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies_bloc.dart';
import 'package:movie_explorer/presentation/blocs/favorites_bloc.dart';
import 'package:movie_explorer/presentation/blocs/favorites_event.dart';
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

    // Instanciation de la source locale avec sqflite
    final localDataSource = SqfliteLocalDataSourceImpl(database: database);

    final repository = MovieRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      apiKey: Env.tmdbApiKey,
    );

    final getPopularMoviesUseCase = GetPopularMoviesUseCase(repository);
    final getFavorites = GetFavoritesUseCase(repository);
    final saveFavorite = SaveFavoriteUseCase(repository);
    final removeFavorite = RemoveFavoriteUseCase(repository);

    return MaterialApp(
      title: 'Movie Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PopularMoviesBloc(
              getPopularMoviesUseCase: getPopularMoviesUseCase,
            ),
          ),
          BlocProvider(
            create: (_) => FavoritesBloc(
              getFavorites: getFavorites,
              saveFavorite: saveFavorite,
              removeFavorite: removeFavorite,
            )..add(LoadFavorites()),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
