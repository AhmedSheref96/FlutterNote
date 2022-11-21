import 'dart:async';

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
    Database mDb = await openDatabase(mDbPath,
        onCreate: _onCreate, onUpgrade: _onUpgrade, version: 11);
    return mDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "notes" ("id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT, "noteTitle" TEXT,"noteDescription" TEXT ,"noteImagesPaths" TEXT)
    ''');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // await db.execute('''
    // ALTER TABLE "notes" ADD "isFav" INTEGER
    // ''');
  }

  readFromDb(String sql) async {
    Database db = await mDb;
    List<Map<String, Object?>> response = await db.rawQuery(sql);
    return response;
  }

  insertIntoDb(String sql) async {
    Database db = await mDb;
    int response = await db.rawInsert(sql);
    return response;
  }

  updateNoteItem(String sql) async {
    Database db = await mDb;
    print("-------------- update sql $sql");
    int response = await db.rawUpdate(sql);
    print("------------------ updated $response");
    return response;
  }

}
