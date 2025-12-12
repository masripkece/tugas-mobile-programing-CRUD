import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/saving.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('saving.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE savings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bulan TEXT NOT NULL,
        jumlah INTEGER NOT NULL
      )
    ''');
  }

  Future<int> createSaving(Saving saving) async {
    final db = await instance.database;
    return await db.insert('savings', saving.toMap());
  }

  Future<List<Saving>> getSavings() async {
    final db = await instance.database;
    final result = await db.query('savings', orderBy: "id DESC");
    return result.map((e) => Saving.fromMap(e)).toList();
  }

  Future<int> updateSaving(Saving saving) async {
    final db = await instance.database;
    return db.update('savings', saving.toMap(),
        where: 'id = ?', whereArgs: [saving.id]);
  }

  Future<int> deleteSaving(int id) async {
    final db = await instance.database;
    return db.delete('savings', where: 'id = ?', whereArgs: [id]);
  }

  /// TOTAL SALDO OTOMATIS
  Future<int> getTotalSaldo() async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT SUM(jumlah) as total FROM savings");

    return result.first["total"] == null ? 0 : result.first["total"] as int;
  }
}
