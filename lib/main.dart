import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/app.dart';

void main() async {
  // Nécessaire car SharedPreferences.getInstance() est asynchrone
  WidgetsFlutterBinding.ensureInitialized();
  
  final sharedPreferences = await SharedPreferences.getInstance();
  
  runApp(MovieExplorerApp(sharedPreferences: sharedPreferences));
}
