import 'package:sqflite/sqflite.dart';
import 'package:movie_explorer/data/datasources/settings_local_data_source.dart';

class SqfliteSettingsDataSourceImpl implements SettingsLocalDataSource {
  final Database database;

  SqfliteSettingsDataSourceImpl(this.database);

  @override
  Future<String?> getPreference(String key) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'preferences',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (maps.isNotEmpty) {
      return maps.first['value'] as String;
    }
    return null;
  }

  @override
  Future<void> savePreference(String key, String value) async {
    await database.insert('preferences', {
      'key': key,
      'value': value,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
