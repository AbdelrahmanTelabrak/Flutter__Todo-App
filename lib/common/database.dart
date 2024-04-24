import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class SqlDB{
  static Database? _db;

  Future<Database> initDB() async {
    String dbPath = await getDatabasesPath();
    String sqlPath = path.join(dbPath, 'todo_db.db');

    Database todoDb = await openDatabase(
      sqlPath,
      onCreate: _onCreate,
      version: 2,
      onUpgrade: _onUpgrade,
    );
    return todoDb;
  }

  Future _onCreate(Database db, int version) async{
    await db.execute("""
      CREATE TABLE "tasks"
        "id" INTEGER PRIMARY KEY
        
    """);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async{
    await db.execute("""
        
    """);
  }

  Future<Database?> getDb() async {
    _db??= await initDB();
    return _db;
  }

  //************* Usage ***********
  Future<List<Map>> readData(String sql) async{
    Database? myDb = await getDb();
    return await myDb!.rawQuery(sql);
  }

  Future<int> insertData(String sql) async{
    Database? myDb = await getDb();
    return await myDb!.rawInsert(sql);
  }

  Future<int> updateData(String sql) async{
    Database? myDb = await getDb();
    return await myDb!.rawUpdate(sql);
  }

  Future<int> deleteData(String sql) async{
    Database? myDb = await getDb();
    return await myDb!.rawDelete(sql);
  }

}