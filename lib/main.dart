import 'package:flutter/material.dart';

import 'package:movie_explorer/core/database/database_config.dart';

import 'package:movie_explorer/core/di/injection.dart';
import 'package:movie_explorer/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await initDatabase();

  // --- INJECTION DE DÉPENDANCES ---
  initDependencies(database);

  runApp(const MovieExplorerApp());
}
