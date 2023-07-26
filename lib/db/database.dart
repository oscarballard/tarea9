import 'package:app/model/location.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocationDatabase {
  static final LocationDatabase instance = LocationDatabase._init();

  static Database? _database;

  LocationDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("event.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const stringType = "Text NOT NULL";
    const  doubleType = "REAL NOT NULL";

    await db.execute('''
CREATE TABLE $tableLocations(
  ${LocationField.id} $idType,
  ${LocationField.title} $stringType,
  ${LocationField.lng} $doubleType,
  ${LocationField.lat} $doubleType
)
''');
  }

  Future<Location> create(Location evento) async {
    // final db = await instance.database;
    final db = await _initDB("event.db");

    final id = await db.insert(tableLocations, evento.toJson());
    return evento.copy(id: id);
  }

  Future<Location> readLocation(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableLocations,
        columns: LocationField.values,
        where: '${LocationField.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Location.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Location>> readAllLocations() async {
    final db = await instance.database;

    const orderBy = '${LocationField.id} ASC';
    final result =
        await db.rawQuery("SELECT * FROM $tableLocations ORDER BY $orderBy");

    return result.map((json) => Location.fromJson(json)).toList();
  }

  Future<int> update(Location evento) async {
    final db = await instance.database;
    return db.update(tableLocations, evento.toJson(),
        where: "${LocationField.id} = ?", whereArgs: [evento.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db
        .delete(tableLocations, where: "${LocationField.id} = ?", whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
