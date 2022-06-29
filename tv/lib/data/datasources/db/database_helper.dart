import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:tv/data/models/tv_table.dart';

class DatabaseTVHelper {
  static DatabaseTVHelper? _databaseTVHelper;
  DatabaseTVHelper._instance() {
    _databaseTVHelper = this;
  }

  factory DatabaseTVHelper() =>
      _databaseTVHelper ?? DatabaseTVHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlistTV = 'watchlist_tv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_tv_series.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblWatchlistTV (
        id INTEGER PRIMARY KEY,
        name TEXT,
        posterPath TEXT,
        overview TEXT
      );
    ''');
  }

  Future<int> insertWatchlistTV(TVTable tv) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTV, tv.toJson());
  }

  Future<int> removeWatchlistTV(TVTable tv) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTV,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTVById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTV,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTV() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistTV);

    return results;
  }
}
