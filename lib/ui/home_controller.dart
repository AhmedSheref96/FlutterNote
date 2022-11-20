import 'package:flutter_note/db/notes_db.dart';
import 'package:flutter_note/models/note_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final NotesDB _db = Get.put(NotesDB());

  get notesItems {
    return _db.readNotes();
  }

  void insertNote() async {
    await _db.insertIntoDb(
      NoteModel(
          id: 1,
          noteTitle: "Hi There",
          noteDescription: "Hi There That Is First Note Item",
          noteImagesPaths: null),
    );
    update();
  }

}
