import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _mDB;

  Future<Database> get mDb async {
    return _mDB ??= await initialDB();
  }

  initialDB() async {
    String dbsPath = await getDatabasesPath();
    String mDbPath = join(dbsPath, "flutterNotesDb.db");
    Database mDb = await openDatabase(mDbPath, onCreate: _onCreate, version: 7);
    print("--------------- create db $mDbPath ");
    return mDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "notes" ("id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT, "noteTitle" TEXT,"noteDescription" TEXT ,"noteImagesPaths" TEXT)
    ''');
    print("--------------- notes table created ");
  }

  readFromDb(String sql) async {
    print("--------------- 00 ");
    Database db = await mDb;

    print("--------------- 11 ");
    List<Map<String, Object?>> response = await db.rawQuery(sql);

    print("--------------- 22 $response ");
    return response;
  }

  insertIntoDb(String sql) async {
    Database db = await mDb;
    int response = await db.rawInsert(sql);
    print("--------------- 55 $response ");
    return response;
  }
}
