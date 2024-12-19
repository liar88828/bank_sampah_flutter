import 'package:bank_sampah/models/waste_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'waste_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE wastes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            type TEXT,
            weight INTEGER,
            date TEXT
          )
        ''').then((value) {
          print("success");
        }).catchError((err) {
          print("error ${err.toString()}");
        });
        print('Table Created');
      },
    );
  }

  Future<int> insertWaste(Waste waste) async {
    final Database db = await database;
    return await db.insert('wastes', waste.toMap());
  }

  Future<List<Waste>> getAllWastes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('wastes', orderBy: 'date DESC');
    return List.generate(maps.length, (i) => Waste.fromMap(maps[i]));
  }

  Future<int> deleteWaste(int id) async {
    final Database db = await database;
    return await db.delete('wastes', where: 'id = ?', whereArgs: [id]);
  }
}
