import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + 'Recipess.db';
    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE SavedRecipes (id INTEGER PRIMARY KEY, title TEXT, imageUrl TEXT)'
      );
    });
  }

  static Future<void> saveRecipe(int id, String title, String imageUrl) async {
    final db = await database;
    await db.insert(
      'SavedRecipes',
      {'id': id, 'title': title, 'imageUrl': imageUrl},
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<Map<String, dynamic>>> getSavedRecipes() async {
    final db = await database;
    return await db.query('SavedRecipes');
  }

  static Future<void> deleteRecipe(int id) async {
    final db = await database;
    await db.delete(
      'SavedRecipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
