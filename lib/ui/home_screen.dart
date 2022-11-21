import 'package:flutter/material.dart';
import 'package:flutter_note/models/note_model.dart';
import 'package:flutter_note/ui/home_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  Container _content() {
    return Container(
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => _notesListView(controller),
      ),
    );
  }

  FutureBuilder<List<NoteModel>> _notesListView(HomeController controller) {
    return FutureBuilder<List<NoteModel>>(
      future: _notesList(controller),
      builder: (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
        return GridView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return noteItemView(controller, (snapshot.data?.elementAt(index))!, index);
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2));
      },
    );
  }

  Card noteItemView(HomeController controller, NoteModel noteModel, int index) {
    late final Icon favIcon;
    if (noteModel.isFav == true) {
      favIcon = const Icon(
        Icons.favorite,
        color: Colors.red,
      );
    } else {
      favIcon = const Icon(
        Icons.favorite_outline,
        color: Colors.red,
      );
    }
    Card itemCard = Card(
      clipBehavior: Clip.antiAlias,
      borderOnForeground: true,
      shadowColor: Colors.blue,
      elevation: .5,
      color: Colors.white,
      margin: const EdgeInsets.all(8),
      semanticContainer: true,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                noteModel.noteTitle ?? "",
                style: const TextStyle(color: Colors.blue, fontSize: 18),
                maxLines: 2,
              ),
              IconButton(
                onPressed: () {
                  noteModel.isFav = !(noteModel.isFav ?? false);
                  controller.updateNoteItem(noteModel);
                },
                icon: favIcon,
              )
            ]),
            Text(
              noteModel.noteDescription ?? "",
              style: const TextStyle(color: Colors.black45, fontSize: 14),
              textAlign: TextAlign.start,
              maxLines: 6,
            ),
          ],
        ),
      ),
    );
    return itemCard;
  }

  Future<List<NoteModel>> _notesList(HomeController controller) async {
    return await controller.notesItems;
  }
}