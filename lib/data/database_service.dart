import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const _dbName = 'doable.db';
  static const _dbVersion = 1;

  static Database? _db;

  static Future<Database> instance() async {
    if (_db != null) return _db!;
    final base = await getDatabasesPath();
    final path = p.join(base, _dbName);
    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            time TEXT,
            date TEXT,
            has_notification INTEGER NOT NULL DEFAULT 0,
            repeat_rule TEXT,
            completed INTEGER NOT NULL DEFAULT 0,
            created_at TEXT DEFAULT CURRENT_TIMESTAMP,
            updated_at TEXT
          )
        ''');
      },
      onUpgrade: (db, oldV, newV) async {
        // Future migrations go here (use db.execute, db.batch).
      },
    );
    return _db!;
  }
}
