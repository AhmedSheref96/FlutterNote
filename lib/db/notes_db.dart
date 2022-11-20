import 'package:flutter_note/db/sql_db.dart';
import 'package:flutter_note/models/note_model.dart';

class NotesDB {
  SqlDb db = SqlDb();

  readNotes() async {
    print("--------------------- reading");
    List<Map<String, Object?>> items =
        await db.readFromDb('SELECT * FROM notes');
    print("--------------------- $items");
    Iterable<NoteModel> mItems = items.map((e) {
      NoteModel item = NoteModel();
      item.noteTitle = e["noteTitle"] as String?;
      item.noteDescription = e["noteDescription"] as String?;
      item.noteImagesPaths = e["noteImagesPaths"] as String?;
      return item;
    });

    print("--------------------- ${mItems.toList()}");
    return mItems.toList();
  }

  insertIntoDb(NoteModel noteItem) async {
    print("--------------------- inserted");
    await db.insertIntoDb(
        "insert into notes (noteTitle,noteDescription,noteImagesPaths) values (${noteItem.noteTitle},${noteItem.noteDescription},${noteItem.noteImagesPaths})");
    print("--------------------- inserted2");
  }
}
