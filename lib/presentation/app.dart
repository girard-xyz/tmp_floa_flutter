import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/config/env.dart';
import '../data/datasources/tmdb/tmdb_api_client.dart';
import '../data/datasources/tmdb/tmdb_remote_data_source_impl.dart';
import '../data/datasources/local/shared_prefs_local_data_source_impl.dart';
import '../data/repositories/movie_repository_impl.dart';
import '../domain/usecases/get_popular_movies_usecase.dart';
import 'blocs/popular_movies_bloc.dart';
import 'pages/home_page.dart';

class MovieExplorerApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MovieExplorerApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: false));

    final tmdbApiClient = TmdbApiClient(dio);
    final remoteDataSource = TmdbRemoteDataSourceImpl(tmdbApiClient);
    
    // Instanciation de la source locale avec nos SharedPreferences injectées
    final localDataSource = SharedPrefsLocalDataSourceImpl(sharedPreferences: sharedPreferences);
    
    final repository = MovieRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource, // Injection du cache
      apiKey: Env.tmdbApiKey, 
    );
    
    final getPopularMoviesUseCase = GetPopularMoviesUseCase(repository);

    return MaterialApp(
      title: 'Movie Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => PopularMoviesBloc(getPopularMoviesUseCase: getPopularMoviesUseCase),
        child: const HomePage(),
      ),
    );
  }
}
