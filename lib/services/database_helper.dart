import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weatherapp/provider/weather_manager.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "favoriten.db";

  static Future<Database> _getDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // await deleteDatabase(join(documentsDirectory.path, _dbName));
    return await openDatabase(join(documentsDirectory.path, _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE IF NOT EXISTS Favoriten(id INTEGER PRIMARY KEY, city TEXT NOT NULL);"),
        version: _version);
  }

  static Future<int> addFavorite(String city) async {
    final db = await _getDB();
    WeatherManager.addToFavoriteList(city);
    return await db.insert("Favoriten", {"city": city});
  }

  static Future<int> deleteFavorite(String city) async {
    final db = await _getDB();

    WeatherManager.deleteFromFavoriteList(city);

    return await db.delete(
      "Favoriten",
      where: "city = ?",
      whereArgs: [city],
    );
  }

  static Future<List<String>?> getAllFavorites() async {
    final db = await _getDB();
    // await db.delete("Favoriten", where: "city = ?", whereArgs: [""]);

    final List<Map<String, dynamic>> maps = await db.query("Favoriten");

    if (maps.isEmpty) {
      WeatherManager.setFavoriteList([]);
      return null;
    }
    List<String> generatedList =
        List.generate(maps.length, (index) => maps[index]["city"]);
    WeatherManager.setFavoriteList(generatedList);

    return generatedList;
  }
}
