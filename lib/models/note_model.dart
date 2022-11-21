class NoteModel {
  NoteModel({
    this.id,
    this.noteTitle,
    this.noteDescription,
    this.noteImagesPaths,
    this.isFav
  });

  int? id;
  String? noteTitle;
  String? noteDescription;
  String? noteImagesPaths;
  bool? isFav;
}
