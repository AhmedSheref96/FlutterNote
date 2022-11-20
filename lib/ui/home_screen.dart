import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.all(16),
        child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return FutureBuilder(
              future: _notesList(controller),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        snapshot.data?.elementAt(index).noteTitle ?? "",
                      ),
                    );
                  },
                );
              },
            );
          },
        ));
  }

  _notesList(HomeController controller) async {
    return await controller.notesItems;
  }
}