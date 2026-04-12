import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> initDatabase() async {
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
      await db.execute(
        'CREATE TABLE cache_movies(id TEXT PRIMARY KEY, title TEXT, year TEXT, image TEXT, rating TEXT)',
      );
      await db.execute(
        'CREATE TABLE favorite_movies(id TEXT PRIMARY KEY, title TEXT, year TEXT, image TEXT, rating TEXT)',
      );
      await db.execute(
        'CREATE TABLE preferences(key TEXT PRIMARY KEY, value TEXT)',
      );
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS preferences(key TEXT PRIMARY KEY, value TEXT)',
        );
      }
    },
    onOpen: (db) async {
      // Force table creation on open specifically for Web DB cache reliability
      await db.execute(
        'CREATE TABLE IF NOT EXISTS preferences(key TEXT PRIMARY KEY, value TEXT)',
      );
    },
    version: 2,
  );

  return database;
}
