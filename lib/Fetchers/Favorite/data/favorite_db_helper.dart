import 'dart:async';
import 'package:movies_app/Fetchers/Home/Repo/Movie_Model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDatabaseHelper {
  static final FavoriteDatabaseHelper _instance = FavoriteDatabaseHelper._internal();

  factory FavoriteDatabaseHelper() => _instance;

  static Database? _database;

  FavoriteDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'movies.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS favorite_movies(
            id TEXT PRIMARY KEY,
            rank INTEGER,
            title TEXT,
            description TEXT,
            image TEXT,
            genre TEXT,
            rating TEXT,
            year INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertMovie(Movie movie) async {
    final db = await database;
    await db.insert(
      'favorite_movies',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Movie>> getFavoriteMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorite_movies');
    return List.generate(maps.length, (i) {
      return Movie(
        rank: maps[i]['rank'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        image: maps[i]['image'],
        genre: maps[i]['genre'].split(','),
        rating: maps[i]['rating'],
        id: maps[i]['id'],
        year: maps[i]['year'],
      );
    });
  }

  Future<void> deleteMovie(String id) async {
    final db = await database;
    await db.delete(
      'favorite_movies',
      where: 'id = ?',
      whereArgs: [id],
    );
  }  
}
