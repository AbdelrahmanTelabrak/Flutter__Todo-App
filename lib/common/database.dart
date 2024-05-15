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
      CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            category TEXT DEFAULT 'assets/icons/ic_cat_task.svg',
            date TEXT DEFAULT CURRENT_DATE,
            time TEXT,
            isDone INTEGER DEFAULT 0
          )
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
  Future<List<Map>> readData(String sql, [List<Object?>? arguments]) async{
    Database? myDb = await getDb();
    return await myDb!.rawQuery(sql, arguments);
  }

  Future<int> insertData(String sql, [List<Object?>? arguments]) async{
    Database? myDb = await getDb();
    return await myDb!.rawInsert(sql, arguments);
  }

  Future<int> updateData(String sql, [List<Object?>? arguments]) async{
    Database? myDb = await getDb();
    return await myDb!.rawUpdate(sql, arguments);
  }

  Future<int> deleteData(String sql, [List<Object?>? arguments]) async{
    Database? myDb = await getDb();
    return await myDb!.rawDelete(sql, arguments);
  }

}