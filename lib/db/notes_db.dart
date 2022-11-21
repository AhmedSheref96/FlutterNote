import 'package:flutter_note/db/sql_db.dart';
import 'package:flutter_note/models/note_model.dart';

class NotesDB {
  SqlDb db = SqlDb();

  readNotes() async {
    List<Map<String, Object?>> items =
        await db.readFromDb('SELECT * FROM notes');
    Iterable<NoteModel> mItems = items.map((e) {
      NoteModel item = NoteModel();
      item.id = e["id"] as int;
      item.noteTitle = e["noteTitle"] as String?;
      item.noteDescription = e["noteDescription"] as String?;
      item.noteImagesPaths = e["noteImagesPaths"] as String?;
      item.isFav = ((e["isFav"] as int?) ?? 0) == 1;
      return item;
    });
    return mItems.toList();
  }

  insertIntoDb(NoteModel noteItem) async {
    int response = await db.insertIntoDb(
        '''INSERT INTO "notes"("noteTitle","noteDescription","noteImagesPaths","isFav") VALUES("${noteItem.noteTitle}","${noteItem.noteDescription}","${noteItem.noteImagesPaths}",0)''');
    return response;
  }

  updateNoteItem(NoteModel item) async {
    int response = await db.updateNoteItem('''
      UPDATE "notes" SET "noteTitle"="${item.noteTitle}" ,"noteDescription"="${item.noteDescription}" ,"noteImagesPaths"="${item.noteImagesPaths}","isFav"="${item.isFav == true ? 1 : 0}"
      WHERE "id"=${item.id}
      ''');
    return response;
  }
}
