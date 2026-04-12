import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:movie_explorer/core/database/database_config.dart';
import 'package:dio/dio.dart';

import 'package:movie_explorer/core/config/env.dart';
import 'package:movie_explorer/data/datasources/tmdb/tmdb_api_client.dart';
import 'package:movie_explorer/data/datasources/tmdb/tmdb_remote_data_source_impl.dart';
import 'package:movie_explorer/data/datasources/local/sqflite_local_data_source_impl.dart';
import 'package:movie_explorer/data/repositories/movie_repository_impl.dart';
import 'package:movie_explorer/data/datasources/local/sqflite_settings_data_source_impl.dart';
import 'package:movie_explorer/data/repositories/settings_repository_impl.dart';

import 'package:movie_explorer/core/di/injection.dart';
import 'package:movie_explorer/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await initDatabase();

  // --- INJECTION DE DÉPENDANCES ---
  initDependencies(database);

  runApp(const MovieExplorerApp());
}
