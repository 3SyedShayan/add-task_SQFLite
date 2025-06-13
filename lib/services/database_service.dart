import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance =
      DatabaseService._constructor(); // Creates a singleton instance
  final String _tasksTableName = "tasks";
  final String _tasksIdColumnName = "id";
  final String _tasksContentColumnName = "content";
  final String _tasksStatusColumnName = "status";
  DatabaseService._constructor(); // Private constructor for singleton pattern
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath =
        await getDatabasesPath(); // Get the default database directory path
    final databasePath = join(
      databaseDirPath,
      'master_db.db',
    ); // Define the database file name
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_tasksTableName {
          $_tasksIdColumnName INTEGER PRIMARY KEY,
          $_tasksContentColumnName TEXT NOT NULL,
          $_tasksStatusColumnName INTEGER NOT NULL,
          }
          ''');
      },
    ); // Open or create the database
    return database;
  }
}
