import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:movie_explorer/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configuration dynamique de SQLite selon la plateforme (Web, Desktop, Mobile)
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  final dbPath = await getDatabasesPath();
  final database = await openDatabase(
    join(dbPath, 'movie_explorer.db'),
    onCreate: (db, version) async {
      // Création table pour le cache offline général
      await db.execute(
        'CREATE TABLE cache_movies(id TEXT PRIMARY KEY, title TEXT, year TEXT, image TEXT, rating TEXT)',
      );
      // Création table pour les favoris
      await db.execute(
        'CREATE TABLE favorite_movies(id TEXT PRIMARY KEY, title TEXT, year TEXT, image TEXT, rating TEXT)',
      );
    },
    version: 1,
  );

  runApp(MovieExplorerApp(database: database));
}
