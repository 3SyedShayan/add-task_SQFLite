import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DataBaseService._constructor();

  DatabaseService._constructor();
  Future<Database> getDatabase() async {}
}
