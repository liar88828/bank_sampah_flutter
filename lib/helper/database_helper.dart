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

  Future<Waste?> getWasteById(int id) async {
    final Database db = await database;

    // Query the database to fetch the waste record by its id
    final List<Map<String, dynamic>> maps = await db.query(
      'wastes', // The table name
      where: 'id = ?', // Condition to match the id
      whereArgs: [id], // Provide the id as an argument to match
    );

    // If a record is found, return it as a Waste object
    if (maps.isNotEmpty) {
      return Waste.fromMap(maps.first); // Convert the first record into a Waste object
    } else {
      return null; // Return null if no record is found
    }
  }


  Future<int> updateWaste(Waste waste) async {
    final Database db = await database;

    // Use the 'update' method to update the record where the 'id' matches.
    return await db.update(
      'wastes',
      waste.toMap(),  // This is the map version of the Waste object.
      where: 'id = ?', // Specify the column (id) to match.
      whereArgs: [waste.id], // Provide the id of the waste to update.
    );
  }

  Future<List<Waste>> getAllWastes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('wastes', orderBy: 'date DESC');
    return List.generate(maps.length, (i) => Waste.fromMap(maps[i]));
  }

  Future<List<Waste>> getAllWastesByType(String type) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'wastes',
      where: 'type = ?', // Use a placeholder for the type
      whereArgs: [type], // Pass the actual value here
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) => Waste.fromMap(maps[i]));
  }

  Future<int> deleteWaste(int id) async {
    final Database db = await database;
    return await db.delete('wastes', where: 'id = ?', whereArgs: [id]);
  }
}
