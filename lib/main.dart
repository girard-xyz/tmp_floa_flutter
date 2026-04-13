import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:movie_explorer/core/database/database_config.dart';

import 'package:movie_explorer/core/di/injection.dart';
import 'package:movie_explorer/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await initDatabase();
  final tempDir = await getTemporaryDirectory();

  // --- INJECTION DE DÉPENDANCES ---
  initDependencies(database, tempDir.path);

  runApp(const MovieExplorerApp());
}
